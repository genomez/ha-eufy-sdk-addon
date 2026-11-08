# S1 experimental.13

SDK 0.2.1-s1.experimental.13; bridge/integration 0.3.1-s1.experimental.13; add-on 0.4.1-s1.experimental.13. Linux amd64.

Recorded playback is progressive by default. Extra camera models are an eligibility opt-in, not proof of codec or lens compatibility. Keep the previous add-on/integration pair and backups for rollback; restore both together and restart Home Assistant. Live view and floodlight safety remain opt-in; keep battery preload off. Command keepalive is 29000 ms.

Publication and final artifact acceptance are pending.

## Historical documentation through experimental.12

# S1 experimental.12

## Cameras to skip for recordings (local development)

**Cameras to skip for recordings** (`recordings_skip_cameras`) defaults to `[]`.
Enter camera names exactly as shown in the Eufy app. Matching is case-insensitive
and ignores surrounding spaces. Skipped cameras get no recording list,
thumbnails or playback, including retained recordings. Restart the add-on after
changing this option. A non-empty list is exported as the JSON array
`RECORDINGS_SKIP_CAMERAS`; commas remain part of camera names. Empty or omitted
leaves the environment variable unset. The matching bridge rejects the entire
value on invalid JSON, non-array input or any non-string/blank entry, skips
nothing and reports only count/source/fixed rejection in policy readback.

```yaml
recordings_skip_cameras: []
```

Recording display uses Home Assistant's configured time zone. Install the matching
integration first: it also accepts the legacy bridge's zone. The matching bridge
uses Supervisor's `TZ`, retaining its station compatibility fallback if absent or
invalid. Quick-start playback defaults to 15 fps and a 3000 ms playable threshold;
`RECORDINGS_PROGRESSIVE_FPS=off` disables it, and live `progressive.json` still
has precedence. These changes add no limit, timer or cap.

## Extra playback camera models (local development)

Set **Extra playback camera models** (`extra_playback_models`, default `[]`) to
a list of model strings, for example `T8212`, then restart the add-on. This lets
outside testers enable recording playback for their own cameras. Untested
models may fail to play and show an error; they never play the wrong video.

```yaml
extra_playback_models:
  - T8212
```

Non-empty lists become comma-separated `RECORDINGS_PLAYBACK_MODELS_EXTRA`.
The matching bridge trims, uppercases and deduplicates them, requiring
`^T\d{4}[A-Z0-9]*$`. Extras extend the environment base or built-in defaults.
Any invalid extra entry rejects the whole extra value, retains the base and
reports `extra_models` in policy readback. Accepted sources include
`default+extra` and `env+extra`. A valid live `playback-models.json` still replaces
everything. An empty option leaves the extra environment variable unset.
No new limits, timers or caps are introduced.

Local development only: these options require the matching bridge change;
the published experimental.12 image has not been rebuilt.

Update the add-on and integration together: add-on `0.4.1-s1.experimental.12`, integration and bridge `0.3.1-s1.experimental.12`, SDK `0.2.1-s1.experimental.12`.

- Push-store save failures are caught and reported through push-connection diagnostics (#539).
- Session and FCM files use an owner-only temporary file and atomic rename where the filesystem permits (#540). On restricted directories or single-file mounts, the existing in-place fallback is non-atomic and retains existing file permissions.
- Stored snapshots recover after a successful re-login, including when an older in-flight download fails afterwards (#545).
- Optional HomeBase S1 storage telemetry also supports firmware 4.4.1.4; it remains off by default.
- After an acknowledged light command, Home Assistant holds the requested display value for up to 45 seconds. A matching boolean report releases it early. The acknowledgement does not confirm the physical light state.
- A registry identity conflict invalidates the affected child-camera status to unknown.
- HomeBase firmware metadata updates from newly received inventory without a Home Assistant restart. A new Firmware version sensor exposes the received version.
- Dated experimental.11 and experimental.12 modification notices are retained, including the restored integration notice.

Defaults are unchanged. Live view and optional floodlight safety remain off by default. Keep battery-camera preload off. Verify the integration ZIP checksum and restart Home Assistant after replacing the integration. Changing live-view opt-in requires an add-on restart. Command keepalive remains 29000 ms.

Known live-view stalls, unexplained floodlight ON events and brightness/spotlight formatting issues remain unresolved. This is an experimental fork.

Runtime and corresponding source: https://github.com/genomez/ha-eufy-sdk-addon/releases/tag/s1-runtime-0.4.1.experimental.12

Integration ZIP and checksum: https://github.com/genomez/ha-eufy-sdk/releases/tag/0.3.1-s1.experimental.12

Publication availability is pending. The accepted image is delivered without rebuilding. Earlier release records below are historical.

Modified for genomez experimental.11, 2026-10-31

Modified for genomez experimental.12, 2026-11-02

## Historical documentation before experimental.12 publication

Modified for genomez experimental.12, 2026-11-02

Current local candidate: experimental.12 (2026-11-02). Unpublished; no installation or device acceptance. Earlier release references below are historical.

# S1 experimental.12 — Add-on configuration

Home Assistant add-on containing the paired bridge and SDK runtime. Update the add-on and integration together.

Pair add-on `0.4.1-s1.experimental.12`, integration/bridge `0.3.1-s1.experimental.12` and SDK `0.2.1-s1.experimental.12`.

Use matching release versions and retain your existing configuration unless deliberately changing an option.

## Changes

- Diagnostics keep bounded failure-only command and property-write history, so failures remain visible when later commands succeed. The SDK error history is limited to 32 entries.
- Event thumbnail decoding supports the V2 encrypted-chroma variant. Alarm pushes that explicitly report an app stop are labelled stopped rather than triggered.
- Unsupported RTSP stream publish controls are hidden for cameras behind HomeBase S1. RTSP URLs and the existing recording/authentication settings retain their existing support rules.
- Streaming-quality sensors behind HomeBase S1 appear only when the camera has reported the corresponding quality parameter. The separate video-quality select is unchanged.
- After updating both components and restarting Home Assistant, 15 existing RTSP stream switches and 15 existing streaming-quality sensors on the affected installation are expected to become unavailable. Their retained entity entries can be removed in Home Assistant. Streaming-quality sensors with reported support remain available.
- Camera-health diagnostics show the last suppressed signal-strength reading, its reason and source. This diagnostic does not change the published signal strength or prove the current radio state.
- More cameras now show Online/Offline status from HomeBase S1 (T9000). Offline/recovery testing covers T8425, T8426, T8416, T8214, T8134 and T8170; T8171 has not yet been offline-tested.
- Camera status holds until the HomeBase reports a change.
- After a HomeBase reconnect, cameras show unknown until the next routine status update, about 10 minutes by default plus polling and sweep time. Failed or disabled polling or missing reports can leave status unknown longer.
- A camera marked offline never holds back light OFF commands or retries. Existing transport and safety checks still apply. Upgrade the add-on and integration together.

## Defaults and use

Defaults are unchanged. Live view is off by default; only boolean `webrtc_relay: true` enables it. Changing that option requires an add-on restart. Command keepalive remains 29000 ms. Integration `light_correction_enabled` remains off. With safety off, OFF-stuck incident reporting is inactive and its four attributes are absent. No new option or default was added. Keep battery-camera preload off.

## Known issues

- T8113-Z firmware 3.3.8 can show a picture then black.
- Some live-view sessions need another open or wait for the hub offer.
- Unexplained floodlight ON events and brightness/spotlight command formatting remain unresolved. This update does not claim to fix these issues. Passive diagnostics do not establish physical state.

## Releases, source and notices

Runtime and corresponding source: https://github.com/genomez/ha-eufy-sdk-addon/releases/tag/s1-runtime-0.4.1.experimental.11

Integration release and ZIP checksum: https://github.com/genomez/ha-eufy-sdk/releases/tag/0.3.1-s1.experimental.11

Image manifest: `sha256:28cc3774423aae12a7a328c0d39c66c317f8c5232466073c356076d1bbd50471`.

See LICENSE and source headers for applicable license and author notices. Runtime/source archives retain their original notices and corresponding-source links.

Full SDK corresponding source: https://github.com/genomez/ha-eufy-sdk-addon/releases/download/s1-runtime-0.4.1.experimental.11/eufy-sdk-0.2.1-s1.experimental.11-source.tar.gz; SHA-256 `d49311318a9522d7cdc6ebb0bddaeaa12bd7d8df383688b414ed294c2b03d465`, 1619648 bytes. The npm package is separate. In-image source records retain their historical build-time values.

## Historical experimental.9 / experimental.10 documentation

# S1 experimental.9 — Add-on configuration

Home Assistant add-on containing the paired bridge and SDK runtime. Update the add-on and integration together.

Pair add-on `0.4.1-s1.experimental.9`, integration/bridge `0.3.1-s1.experimental.9` and SDK `0.2.1-s1.experimental.9`.

Use the matching release versions and retain your existing configuration unless deliberately changing an option.

## Changes

- Failed SDK background read-through refreshes report through the existing `state_refresh` origin and retain last-known values until an update succeeds.
- Routine camera health attributes refresh less often. On one installation, 15 connectivity sensors went from about 317,000 recorder rows a day to about 1,600.
- With the existing optional floodlight safety enabled, unconfirmed OFF incidents expose `off_stuck_incident`, `off_stuck_reason`, `off_stuck_opened_at` and `off_stuck_escalate_at`.
- SDK Markdown formatting was corrected. A test-only change uses 5.0015 seconds to avoid clock rounding; production timing is unchanged.

## Defaults and use

Live view is off by default; only boolean `webrtc_relay: true` enables it. Live-view opt-in requires an add-on restart. Command keepalive remains 29000 ms. Integration `light_correction_enabled` remains off. With safety off, OFF-stuck incident reporting is inactive and its four attributes are absent. No new option or default was added. Keep battery-camera preload off.

## Known issues

T8113-Z firmware 3.3.8 can show a picture then black. Some live-view sessions need another open or wait for the hub offer. Unexplained floodlight ON events and brightness/spotlight command formatting remain unresolved. This release does not claim to fix these issues. Passive diagnostics do not establish physical state.

## Releases, source and notices

Runtime and corresponding source: https://github.com/genomez/ha-eufy-sdk-addon/releases/tag/s1-runtime-0.4.1.experimental.9

Integration release and ZIP checksum: https://github.com/genomez/ha-eufy-sdk/releases/tag/0.3.1-s1.experimental.9

Image manifest: `sha256:fe2fca682ecf41655402abc7ba2da970995eeed4a6010f51865409b60141bd0e`. The integration release archive corresponds to source commit `bf6d218faa3df8734c8bfee594ed6ae6e807e1f3`; current branch documentation can differ from that tagged archive.

See LICENSE and source headers for applicable license and author notices. Runtime/source archives retain their original notices and immutable base corresponding-source links.

## Historical experimental.8 documentation

# Experimental.8 verified public delivery

Runtime/source release: https://github.com/genomez/ha-eufy-sdk-addon/releases/tag/s1-runtime-0.4.1.experimental.8
Integration release: https://github.com/genomez/ha-eufy-sdk/releases/tag/0.3.1-s1.experimental.8
Verified registry manifest: sha256:4289f94e617c0e60207edb8ddaa75d88cfdf777ad081e9e43feb915a4b2ef119
Paired add-on 0.4.1-s1.experimental.8, integration/bridge 0.3.1-s1.experimental.8 and SDK 0.2.1-s1.experimental.8. These bindings come from independent anonymous release, asset, workflow and registry verification. Installation, HACS and physical-device acceptance remain separate.

The official integration ZIP remains frozen at 6bb1365de39615d9e094b44b7665118451326e8d; current branch documentation may differ from the release archive. Version-specific source, image-context and archive records below remain historical. The exact prepared implementation and workflow are unchanged.

## Historical local preparation and earlier release records

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
