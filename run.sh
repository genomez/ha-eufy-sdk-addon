#!/bin/sh
# Add-on entrypoint: translate Home Assistant add-on options â†’ the env the bridge reads, then hand off.
#
# HA writes the user's options to /data/options.json (not env), so this is the one glue step the thin
# wrapper adds on top of the bridge image. /data is the add-on's persistent volume, so the login token
# survives restarts. Account/session interactions require separate validation.
set -e
umask 077

OPTS=/data/options.json
SUPERVISOR_API="${SUPERVISOR:-http://supervisor}"

export EUFY_EMAIL="$(jq -r '.email // ""' "$OPTS")"
export EUFY_PASSWORD="$(jq -r '.password // ""' "$OPTS")"
export EUFY_COUNTRY="$(jq -r '.country // "GB"' "$OPTS")"
export EUFY_SESSION="/data/.eufy-session.json"
export GO2RTC_CONFIG="/data/go2rtc.yaml"
# Reachable through ingress + the hosted go2rtc ports (not just localhost).
export BRIDGE_HOST="0.0.0.0"

# Optional tuning â†’ bridge env. Defaults in config.yaml mirror the bridge's own, so these are a no-op
# unless the user changes them. debug is a bool option; map it to the truthy string the bridge expects.
export EUFY_POLL_MS="$(jq -r '.poll_ms // 600000' "$OPTS")"
export BRIDGE_RTC_STATE_REFRESH_MS="$(jq -r '.rtc_state_refresh_ms // 0' "$OPTS")"
# Strict opt-in; inherited environment cannot enable storage when the option is off.
export BRIDGE_S1_STORAGE_TELEMETRY="$(jq -r 'if .s1_storage_telemetry == true then "1" else "0" end' "$OPTS")"
# Strict opt-in; inherited environment cannot enable the relay when the option is off.
export BRIDGE_WEBRTC_RELAY="$(jq -r 'if .webrtc_relay == true then "1" else "0" end' "$OPTS")"
export STREAM_IDLE_MS="$(jq -r '.stream_idle_ms // 300000' "$OPTS")"
export RTSP_IDLE_OFF_MS="$(jq -r '.rtsp_idle_off_ms // 300000' "$OPTS")"
# Optional: battery stream budget. Unset keeps the SDK default, so only pass it when the user sets one.
budget_ms="$(jq -r '.stream_battery_budget_ms // empty' "$OPTS")"
[ -n "$budget_ms" ] && export STREAM_BATTERY_BUDGET_MS="$budget_ms"
# Feature toggle: speculative P2P prewarm on high-intent events (off by default).
[ "$(jq -r '.prewarm // false' "$OPTS")" = "true" ] && export BRIDGE_PREWARM=1
# Per-event log line is on by default in the bridge; only override when the user turns it off.
[ "$(jq -r 'if .event_log == null then true else .event_log end' "$OPTS")" = "false" ] && export BRIDGE_EVENT_LOG=0
[ "$(jq -r '.debug // false' "$OPTS")" = "true" ] && export BRIDGE_DEBUG=1
[ "$(jq -r '.debug_p2p // false' "$OPTS")" = "true" ] && export BRIDGE_DEBUG_P2P=1
# Bundled go2rtc is on by default; only pass the override when the user turns it off.
[ "$(jq -r 'if .go2rtc_enable == null then true else .go2rtc_enable end' "$OPTS")" = "false" ] && export GO2RTC_ENABLE=0

# Optional Anker Solix (a SEPARATE Anker account from eufy). Empty email/password â‡’ Solix stays off
# (the bridge enables it only when BOTH are set). Empty country â‡’ the bridge falls back to EUFY_COUNTRY.
# Its session persists on /data so the Solix login token survives restarts, like the eufy one.
export SOLIX_EMAIL="$(jq -r '.solix_email // ""' "$OPTS")"
export SOLIX_PASSWORD="$(jq -r '.solix_password // ""' "$OPTS")"
export SOLIX_COUNTRY="$(jq -r '.solix_country // ""' "$OPTS")"
export SOLIX_SESSION="/data/.solix-session.json"
export SOLIX_SCENE_POLL_MS="$(jq -r '.solix_scene_poll_ms // 90000' "$OPTS")"
export SOLIX_RETRY_BASE_MS="$(jq -r '.solix_retry_base_ms // 900000' "$OPTS")"
export SOLIX_RETRY_MAX_MS="$(jq -r '.solix_retry_max_ms // 3600000' "$OPTS")"

register_discovery() {
  if [ -z "${SUPERVISOR_TOKEN:-}" ]; then
    echo "[addon] SUPERVISOR_TOKEN is unavailable; skipping eufy_sdk discovery"
    return
  fi

  addon_info="$(curl -fsS -H "Authorization: Bearer ${SUPERVISOR_TOKEN}" "${SUPERVISOR_API}/addons/self/info" 2>/dev/null)" || {
    echo "[addon] could not read Supervisor add-on info; skipping eufy_sdk discovery"
    return
  }
  # Core can reach the add-on by internal DNS even when host ports are disabled.
  # Using the Docker gateway with unpublished ports advertises an unreachable endpoint.
  bridge_host="$(printf '%s' "$addon_info" | jq -r '.data.hostname // empty')"
  if [ -z "$bridge_host" ]; then
    echo "[addon] Supervisor omitted the add-on hostname; skipping discovery"
    return
  fi
  bridge_port=3000
  rtsp_port=8554

  discovery_payload="$(
    jq -cn \
      --arg host "$bridge_host" \
      --argjson port "$bridge_port" \
      --argjson rtsp_port "$rtsp_port" \
      '{
        service: "eufy_sdk",
        config: {
          host: $host,
          port: $port,
          go2rtc_rtsp_port: $rtsp_port
        }
      }'
  )"

  if curl -fsS -X POST -H "Authorization: Bearer ${SUPERVISOR_TOKEN}" -H "Content-Type: application/json" \
    -d "$discovery_payload" "${SUPERVISOR_API}/discovery" >/dev/null 2>&1; then
    echo "[addon] registered eufy_sdk discovery"
  else
    echo "[addon] could not register eufy_sdk discovery"
  fi
}

wait_for_bridge() {
  health_url="http://127.0.0.1:${BRIDGE_PORT:-3000}/healthz"
  ready_timeout_sec=30
  attempt=1

  echo "[addon] waiting for bridge health before registering discovery"
  until curl -fsS "$health_url" >/dev/null 2>&1; do
    if ! kill -0 "$bridge_pid" 2>/dev/null; then
      echo "[addon] bridge exited before discovery could be registered"
      return 1
    fi
    if [ "$attempt" -ge "$ready_timeout_sec" ]; then
      echo "[addon] bridge did not become healthy within ${ready_timeout_sec}s; skipping eufy_sdk discovery"
      return 1
    fi
    attempt=$((attempt + 1))
    sleep 1
  done
}

# Contract with ha-eufy-sdk-bridge: the bridge image provides this launcher, which starts the daemon
# AND go2rtc. Start it first so HA's discovery flow can immediately validate the WebSocket.
/usr/local/bin/eufy-sdk-bridge &
bridge_pid="$!"

stop_bridge() {
  kill -TERM "$bridge_pid" 2>/dev/null || true
  # Exit from the trap with the child result, not the interrupted outer wait.
  if wait "$bridge_pid"; then
    exit 0
  else
    exit "$?"
  fi
}
trap stop_bridge TERM INT

(
  wait_for_bridge && register_discovery
) &

wait "$bridge_pid"
