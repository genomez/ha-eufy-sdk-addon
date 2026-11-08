# S1 experimental.13

SDK 0.2.1-s1.experimental.13; bridge/integration 0.3.1-s1.experimental.13; add-on 0.4.1-s1.experimental.13. Linux amd64.

Recorded playback is progressive by default. Extra camera models are an eligibility opt-in, not proof of codec or lens compatibility. Keep the previous add-on/integration pair and backups for rollback; restore both together and restart Home Assistant. Live view and floodlight safety remain opt-in; keep battery preload off. Command keepalive is 29000 ms.

Publication and final artifact acceptance are pending.

## Historical documentation through experimental.12

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

# S1 experimental.12 — Overview

Home Assistant add-on containing the paired bridge and SDK runtime. Update the add-on and integration together.

Pair add-on `0.4.1-s1.experimental.12`, integration/bridge `0.3.1-s1.experimental.12` and SDK `0.2.1-s1.experimental.12`.

Update the add-on and integration together and retain your existing configuration. This is an experimental fork, not an official upstream release.

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

## Modification and attribution notices

Modified for genomez experimental.9, 2026-10-27.

## Files modified in experimental.11

- `.github/workflows/publish-s1-image.yml`
- `CANDIDATE.json`
- `DOCS.md`
- `EXPERIMENTAL.md`
- `MIGRATION.md`
- `PUBLICATION.json`
- `README.md`
- `RELEASE_CHECKLIST.md`
- `SOURCE_MANIFEST.json`
- `eufy_sdk_s1/CHANGELOG.md`
- `eufy_sdk_s1/DOCS.md`
- `eufy_sdk_s1/config.yaml`
- `packaging/EXPERIMENTAL11_OVERLAY.json`
- `packaging/experimental11-overlay.Dockerfile`
- `root/app/BUILD_PROVENANCE.json`
- `root/app/EXPERIMENTAL.md`
- `root/app/MODIFICATIONS.md`
- `root/app/PUBLICATION.json`
- `root/app/README.md`
- `root/app/REVIEW_TEST_PROVENANCE.json`
- `root/app/SOURCE_MANIFEST.json`
- `root/app/node_modules/@mega-yfue/eufy-sdk/BUILD_PROVENANCE.json`
- `root/app/node_modules/@mega-yfue/eufy-sdk/EXPERIMENTAL.md`
- `root/app/node_modules/@mega-yfue/eufy-sdk/MODIFICATIONS.md`
- `root/app/node_modules/@mega-yfue/eufy-sdk/PUBLICATION.json`
- `root/app/node_modules/@mega-yfue/eufy-sdk/README.md`
- `root/app/node_modules/@mega-yfue/eufy-sdk/SOURCE_MANIFEST.json`
- `root/app/node_modules/@mega-yfue/eufy-sdk/dist/client/camera-health-ingress.d.ts`
- `root/app/node_modules/@mega-yfue/eufy-sdk/dist/client/camera-health.d.ts`
- `root/app/node_modules/@mega-yfue/eufy-sdk/dist/client/eufy-mega.d.ts`
- `root/app/node_modules/@mega-yfue/eufy-sdk/dist/index.js`
- `root/app/node_modules/@mega-yfue/eufy-sdk/dist/index.js.map`
- `root/app/node_modules/@mega-yfue/eufy-sdk/dist/model/capabilities/camera.d.ts`
- `root/app/node_modules/@mega-yfue/eufy-sdk/dist/model/capabilities/index.d.ts`
- `root/app/node_modules/@mega-yfue/eufy-sdk/dist/model/capabilities/rtsp.d.ts`
- `root/app/node_modules/@mega-yfue/eufy-sdk/dist/transport/rtc/command-diagnostics.d.ts`
- `root/app/node_modules/@mega-yfue/eufy-sdk/dist/transport/rtc/command-router.d.ts`
- `root/app/node_modules/@mega-yfue/eufy-sdk/package-lock.json`
- `root/app/node_modules/@mega-yfue/eufy-sdk/package.json`
- `root/app/package-lock.json`
- `root/app/package.json`
- `root/app/src/camera-health.mjs`
- `root/app/src/diagnostics.mjs`
- `root/app/src/ws-server.mjs`
- `root/recipe/experimental11/Dockerfile`
- `root/recipe/experimental11/SOURCE_INPUTS.json`
- `root/usr/share/licenses/eufy/SOURCE_ACCESS.md`
- `root/usr/share/licenses/eufy/SOURCE_COMPONENTS.json`
- `root/usr/share/licenses/eufy/bridge/BUILD_PROVENANCE.json`
- `root/usr/share/licenses/eufy/bridge/EXPERIMENTAL.md`
- `root/usr/share/licenses/eufy/bridge/MODIFICATIONS.md`
- `root/usr/share/licenses/eufy/bridge/README.md`
- `root/usr/share/licenses/eufy/experimental7/HISTORICAL_RECORD.json`
- `root/usr/share/licenses/eufy/experimental7/SOURCE_ACCESS.md`
- `root/usr/share/licenses/eufy/experimental7/SOURCE_COMPONENTS.json`
- `root/usr/share/licenses/eufy/experimental7/bridge/BUILD_PROVENANCE.json`
- `root/usr/share/licenses/eufy/experimental7/sdk/BUILD_PROVENANCE.json`
- `root/usr/share/licenses/eufy/sdk/BUILD_PROVENANCE.json`
- `root/usr/share/licenses/eufy/sdk/EXPERIMENTAL.md`
- `root/usr/share/licenses/eufy/sdk/MODIFICATIONS.md`
- `root/usr/share/licenses/eufy/sdk/README.md`

Full SDK corresponding source: https://github.com/genomez/ha-eufy-sdk-addon/releases/download/s1-runtime-0.4.1.experimental.11/eufy-sdk-0.2.1-s1.experimental.11-source.tar.gz; SHA-256 `d49311318a9522d7cdc6ebb0bddaeaa12bd7d8df383688b414ed294c2b03d465`, 1619648 bytes. The npm package is separate. In-image source records retain their historical build-time values.

## Historical experimental.9 / experimental.10 documentation

# S1 experimental.9 — Overview

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

## Files modified in experimental.9

Modified for genomez experimental.9, 2026-10-27.

- `.github/workflows/publish-s1-image.yml`
- `CANDIDATE.json`
- `DOCS.md`
- `EXPERIMENTAL.md`
- `MIGRATION.md`
- `PUBLICATION.json`
- `README.md`
- `RELEASE_CHECKLIST.md`
- `SOURCE_MANIFEST.json`
- `eufy_sdk_s1/CHANGELOG.md`
- `eufy_sdk_s1/DOCS.md`
- `eufy_sdk_s1/config.yaml`
- `packaging/EXPERIMENTAL9_OVERLAY.json`
- `packaging/experimental9-overlay.Dockerfile`
- `root/app/BUILD_PROVENANCE.json`
- `root/app/EXPERIMENTAL.md`
- `root/app/MODIFICATIONS.md`
- `root/app/README.md`
- `root/app/REVIEW_TEST_PROVENANCE.json`
- `root/app/SOURCE_MANIFEST.json`
- `root/app/node_modules/@mega-yfue/eufy-sdk/BUILD_PROVENANCE.json`
- `root/app/node_modules/@mega-yfue/eufy-sdk/EXPERIMENTAL.md`
- `root/app/node_modules/@mega-yfue/eufy-sdk/MODIFICATIONS.md`
- `root/app/node_modules/@mega-yfue/eufy-sdk/README.md`
- `root/app/node_modules/@mega-yfue/eufy-sdk/SOURCE_MANIFEST.json`
- `root/app/node_modules/@mega-yfue/eufy-sdk/dist/client/eufy-mega.d.ts`
- `root/app/node_modules/@mega-yfue/eufy-sdk/dist/index.js`
- `root/app/node_modules/@mega-yfue/eufy-sdk/dist/index.js.map`
- `root/app/node_modules/@mega-yfue/eufy-sdk/package-lock.json`
- `root/app/node_modules/@mega-yfue/eufy-sdk/package.json`
- `root/app/package-lock.json`
- `root/app/package.json`

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

# Experimental.6 release

Add-on `0.4.1-s1.experimental.6` pairs SDK `0.2.1-s1.experimental.6`, bridge `0.3.1-s1.experimental.6` and integration `0.3.1-s1.experimental.6` for Linux amd64. Versions and the default-off relay option are owner approved. The runtime and integration prereleases are published; see the verified links below.

The code payload is identical to review.9: 179 SDK dist files, 15 bridge source modules and server.mjs. Both installed package objects change only their version. Current source packaging commit is `c254aac11d4ad8e599cd14fa89e5e47e33264516`; integration commit is `071c55bf4a9f606eea7603ff3946a52965b2e774`. Its ZIP is 526898 bytes, SHA-256 `23d90f50a19494d411f071864dd40122bcc8ef47468d5b949e669cc1b0f99154`.

Native live view runs in Home Assistant's player when `webrtc_relay` is set to boolean `true` and the add-on is restarted; the integration selects it automatically. The option defaults to `false`; false, absent and non-boolean values override inherited relay enablement to zero. Image command-session keepalive stays 29000 ms independently. Update both the add-on and integration, and turn off Preload camera stream for battery cameras.

This refresh includes the battery-camera stream fix, floodlight late-reply handling with bounded automatic state correction, supported S1 camera sirens, standard doorbell ring events and faster live-view admission. A slow camera may fail at 15 seconds on its first live-view attempt; retry. Doorbell presses may arrive more than once, and live view takes a few seconds to release. Experimental status remains.

The overlay uses the exact immutable experimental.4 digest used by review.9, rather than the earlier candidate's experimental.5 base. The complete code overlay includes the later fixes; native, Go, OS and launcher dependencies are inherited. Configurable startup and release/source metadata intentionally differ from review.9. Full image equivalence and physical-device acceptance are not asserted.

Current source/license records replace stale inherited records in /app, its SDK package and /usr/share/licenses/eufy. Historical base recipe/source chain remains preserved; current recipe/manifest is installed separately under /recipe/experimental6. Trial image results are recorded separately. Release assets and registry image are independently verified. Installation, exact-image hardware, HA/HACS and soak acceptance remain separate. No package installation occurs in this overlay.

Verified runtime/source release: https://github.com/genomez/ha-eufy-sdk-addon/releases/tag/s1-runtime-0.4.1.experimental.6

Verified companion integration release: https://github.com/genomez/ha-eufy-sdk/releases/tag/0.3.1-s1.experimental.6
