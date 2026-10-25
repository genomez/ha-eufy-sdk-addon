# Experimental.8 local preparation

Version `0.4.1-s1.experimental.8` is prepared locally and unpublished. Pair add-on `0.4.1-s1.experimental.8`, integration/bridge `0.3.1-s1.experimental.8` and SDK `0.2.1-s1.experimental.8`.

RTC late-viewer keyframe gating; bounded refresh backoff and recovery; isolated slow replies; camera connectivity and hub reply evidence; T8171 detection; opt-in floodlight safety with bounded confirmation and problem notices; observation-only media stall evidence.

Live view remains off by default; only boolean `webrtc_relay: true` enables it. Command keepalive remains 29000 ms. Integration floodlight safety uses `light_correction_enabled` and remains off by default. The opt-in safety binds HA intent, uses 15-minute motion and ON waits with a 30-minute watchdog, retries OFF until camera confirmation within its limits, and reports problems with bounded phone retries. It may retry an authorized ON intent; the historical .7 OFF-only corrector description below is superseded. Passive connectivity diagnostics do not establish physical state.

Media gap evidence is observation only; no automatic stream restart is added. T8113-Z firmware 3.3.8 picture-then-black remains unresolved. A second live-view open may still be needed. Brightness/spotlight formatting and unexplained floodlight ON events remain under investigation. The refresh retry/backoff addresses the prior .7 refresh issue.

This is an offline local candidate, with no release, registry, installation, account, device, media or new soak acceptance. Update and installation instructions in the historical text apply only after a separately approved publication.

## Historical published experimental.7 documentation

Current integration source input `689ee3c33b995734085e99089f5fb1ce7605c176`; prepared commit `b3922d91fcd73a10b763b69dfcf1c4d72ccc7a1f`. ZIP SHA-256 `d944bb4c1db048d6edc2372640e56caea51a4806bd9cb2d91df7c09b840806ca`, 633821 bytes, 59 members. REBUILD.md and both pairing JSON records agree. Automatic floodlight correction is OFF-only and never re-sends ON; the shared command-health gate pauses automatic sends after repeated fast refusals.

# Experimental.7 local preparation

Current pairing: add-on `0.4.1-s1.experimental.7`, integration `0.3.1-s1.experimental.7`, bridge `0.3.1-s1.experimental.7`, SDK `0.2.1-s1.experimental.7`. Runtime delivery: https://github.com/genomez/ha-eufy-sdk-addon/releases/tag/s1-runtime-0.4.1.experimental.7. Integration delivery: https://github.com/genomez/ha-eufy-sdk/releases/tag/0.3.1-s1.experimental.7. Public relay default remains false; opt into live view with `webrtc_relay: true`. Integration owns optional automatic floodlight correction. Runtime source is `6deea127459f368edb24d7d3df59dcaf60d5b508`. Current recipe is `packaging/experimental7-overlay.Dockerfile`; earlier version-specific instructions below are historical. Publication and installation require separate approval.

# Configuration

Experimental installer `0.4.1-s1.experimental.6` is paired with the independently verified published amd64 image. Review [candidate bindings](../CANDIDATE.json), [runtime/source recipes](../DOCS.md), [release prerequisites](../RELEASE_CHECKLIST.md) and [migration/rollback](../MIGRATION.md) before any owner-approved installation. Published registry manifest/config/layer identity and corresponding-source downloads are verified; installation and live acceptance remain separate.

Enter your own Eufy account email, password and account country in the add-on's private configuration. `GB` is an inherited placeholder default, not automatic country detection. Do not post options, session files, account details or raw logs in an issue. Complete any requested authentication yourself through the integration's supported authentication flow; repeated logins are not a troubleshooting strategy.

Only one bridge process should use the account during migration and qualification. Keep the previous bridge stopped, with its automatic start and watchdog disabled during cutover. The new add-on defaults to manual start. Its new repository/slug identity has separate private storage: installing it does not migrate the previous add-on's `/data`.

Home Assistant Core connects through the hostname shown by Supervisor for this installed add-on, bridge port `3000`; RTSP uses internal port `8554`. Do not guess a repository hash or use the old add-on hostname. The runtime announces discovery, but this integration candidate does not implement a Supervisor discovery handler; use the existing integration entry's Reconfigure action for migration, or a single new entry for a genuinely new installation. Ingress is separate from Core's bridge connection.

The configuration lists optional host mappings for ports 3000 and 8554 with both disabled. Enabling them can expose bridge controls/media beyond the internal add-on network. It is unnecessary for Core on the same Supervisor. This experimental release targets that topology; an externally hosted Core/bridge requires separate network validation.

## Defaults

- `poll_ms: 600000`: ordinary cloud polling interval; zero disables it.
- `rtc_state_refresh_ms: 0`: shared RTC state refresh is disabled. To opt in, use 30000 through 600000 milliseconds; values from 1 through 29999 are not a supported setting even though the inherited form accepts them.
- `s1_storage_telemetry: false`: optional limited model/firmware storage probe remains off.
- `webrtc_relay: false`: opt-in native live view. Only boolean true enables it. False, absent or non-boolean values disable inherited relay enablement. Set true, restart the add-on, and the paired integration selects it automatically.
- Image command keepalive remains `BRIDGE_RTC_COMMAND_KEEPALIVE_MS=29000`, independent of `webrtc_relay`.
- `stream_idle_ms: 300000`, `rtsp_idle_off_ms: 0`, `prewarm: false`: inherited candidate defaults. Battery cameras still have their own stream budget. Optional `stream_battery_budget_ms` changes that budget; it is not a universal connection timeout.
- `event_log`, `debug`, `debug_p2p`: all false. Keep raw event and protocol diagnostics private if explicitly enabled later.
- `go2rtc_enable: true`: uses the bundled media service. An external go2rtc arrangement is not qualified by this package.
- Solix fields are optional, separate from the Eufy account, and remain empty/off by default.

The add-on's `timeout: 60` is Supervisor's stop grace period, allowing the runtime's bounded shutdown to finish. It is not a 60-second live-view limit or a timer that restarts the bridge.

Configuration changes are not automatic device acceptance. Verify reported connection/read health and controlled live-view behavior separately after an explicitly scheduled installation.

Update both this add-on and the integration from `0.3.1.dev2` to `0.3.1-s1.experimental.6`. Turn off Preload camera stream for battery cameras. This refresh uses review.9 code; see root DOCS.md for exact source and ZIP bindings. Trial-build qualification is separate from installation and physical-device acceptance.

Update both this add-on and the integration from `0.3.1.dev2` to `0.3.1-s1.experimental.6`. Turn off Preload camera stream for battery cameras. This refresh uses review.9 code; see root DOCS.md for exact source and ZIP bindings. Trial-build qualification is separate from installation and physical-device acceptance.

Update both this add-on and the integration from `0.3.1.dev2` to `0.3.1-s1.experimental.6`. Turn off Preload camera stream for battery cameras. This refresh uses review.9 code; see root DOCS.md for exact source and ZIP bindings. Trial-build qualification is separate from installation and physical-device acceptance.

Verified runtime/source release: https://github.com/genomez/ha-eufy-sdk-addon/releases/tag/s1-runtime-0.4.1.experimental.6

Verified companion integration release: https://github.com/genomez/ha-eufy-sdk/releases/tag/0.3.1-s1.experimental.6
