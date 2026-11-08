# Unreleased (local development)

- Add **Cameras to skip for recordings** (`recordings_skip_cameras`, default `[]`),
  applied on restart through JSON `RECORDINGS_SKIP_CAMERAS` in the matching bridge.
  Skipped cameras have no recordings, thumbnails or playback.
- Matching bridge reports its actual recording zone; integration displays times
  in Home Assistant's configured zone. Install the integration first.
- Matching bridge enables 15 fps quick-start playback by default; live policy
  overrides remain supported and the playable default stays 3000 ms.

- Add optional **Extra playback camera models** (`extra_playback_models`, default
  empty). Restart applies the list through `RECORDINGS_PLAYBACK_MODELS_EXTRA` to
  a matching bridge. Invalid extras reject atomically with policy diagnostics;
  a valid live model file retains full precedence. Untested models may show a
  playback error; recording identity checks remain in force.

# S1 experimental.12

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

# S1 experimental.12 — Change log

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

# S1 experimental.9 — Change log

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

# 0.4.1-s1.experimental.8

RTC late-viewer keyframe gating; bounded refresh backoff and recovery; isolated slow replies; camera connectivity and hub reply evidence; T8171 detection; opt-in floodlight safety with bounded confirmation and problem notices; observation-only media stall evidence.

Historical .7 changelog follows.

# 0.4.1-s1.experimental.7

- Back off RTC renewals after busy responses and preserve the cause of connection initialization failures.
- Add passive connection, watchdog and cloud-poll diagnostics.
- Pair integration 0.3.1-s1.experimental.7 for four app-aligned presets and motion-aware floodlight correction.
- Live view remains opt-in with webrtc_relay; default false and 29-second command keepalive retained.

# 0.4.1-s1.experimental.6 experimental

SDK `0.2.1-s1.experimental.6`, bridge `0.3.1-s1.experimental.6`, integration `0.3.1-s1.experimental.6`; Linux amd64. Published experimental prerelease.

- Optional native live view in Home Assistant's player: set `webrtc_relay` to true and restart the add-on. Off by default; integration selects it automatically.
- Fix battery-camera streaming; update both components and turn off Preload camera stream on battery cameras.
- Handle eligible floodlight late replies without a spurious error and reconcile state automatically.
- Add siren support on supported S1 cameras and a standard doorbell ring event; reduce live-view start overhead.
- Retain freshness guards, power classification, redaction, bounded recovery and independent 29000 ms command keepalive.
- Refresh to review.9 code and its exact experimental.4 base. Trial image evidence is separate from physical-device and stock-Core qualification.

A slow camera can fail at 15 seconds on its first live-view attempt; retry. Doorbell presses may arrive more than once. Live view takes a few seconds to release. This remains experimental.

# 0.4.1-s1.experimental.5 experimental

SDK `0.2.1-s1.experimental.5` and bridge `0.3.1-s1.experimental.5`, paired with unchanged integration `0.3.1.dev2`, for Linux amd64.

- Confirm floodlight writes, close every command channel during teardown, and back off after empty refresh replies.
- Do not report a battery charge source for known mains cameras; treat the `-100` Wi-Fi placeholder as no reading.
- Report storage collection attempts and failures; redact tokens from RTC signing refusals.
- Enable command-session keepalive at 29 seconds in the image (`BRIDGE_RTC_COMMAND_KEEPALIVE_MS=29000`). The SDK facility remains opt-in outside the image. A prior approximately 9.5-hour HomeBase S1 experiment recorded 1,138 of 1,138 echoes and zero drops; the exact .5 image passed an in-image smoke test but has not itself been run on hardware.

Built on the immutable published experimental.4 image with one new layer. Live view is not included. Runtime and sources: https://github.com/genomez/ha-eufy-sdk-addon/releases/tag/s1-runtime-0.4.1.experimental.5

# 0.4.1-s1.experimental.4 experimental

SDK `0.2.1-s1.experimental.4` and bridge `0.3.1-s1.experimental.4`, paired with integration `0.3.1.dev2`.

- Each SDK error report now carries a fixed origin label. The bridge's cached `sdkErrors` diagnostics add `lastOrigin`, per-origin counts and the last 10 errors (time, type and origin only; no error text or identifiers).
- Session renewal retries once, after a 30-second cooldown, when a verified replacement times out while the old session is briefly busy (from the unpublished experimental.3).

Runtime options and defaults are unchanged. Not yet tested on physical hardware. Runtime and sources: https://github.com/genomez/ha-eufy-sdk-addon/releases/tag/s1-runtime-0.4.1.experimental.4

# 0.4.1-s1.experimental.2 experimental

The SDK local ICE callback sends only while its signaling socket is open. The paired integration candidate adds detection-mask safety. Bridge implementation, runtime options/defaults, native/Go/OS artifacts, launcher and add-on identity remain. Exact base-plus-patch source and package bindings accompany the runtime. Supervisor installation, stock-Core media and physical-device acceptance remain separate.

# 0.4.1-s1.experimental.1 experimental

Separate S1 experimental add-on identity and prebuilt-image metadata around the retained synthetic-qualified amd64 container; [runtime archive and corresponding sources](https://github.com/genomez/ha-eufy-sdk-addon/releases/tag/s1-runtime-0.4.1.experimental.1). SDK/bridge runtime sources are unchanged from the reviewed source preview. Added migration, single integration ownership, private-data and rollback instructions. Registry digest/anonymous-pull verification is recorded separately in CANDIDATE.json. Supervisor migration, HACS replacement UI, stock-Core media, camera switching and physical-device acceptance remain unverified.

Verified runtime/source release: https://github.com/genomez/ha-eufy-sdk-addon/releases/tag/s1-runtime-0.4.1.experimental.6

Verified companion integration release: https://github.com/genomez/ha-eufy-sdk/releases/tag/0.3.1-s1.experimental.6
