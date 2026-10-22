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
