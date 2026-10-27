# S1 experimental.9 — Configuration and use

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

# Experimental.6 release

Add-on `0.4.1-s1.experimental.6` pairs SDK `0.2.1-s1.experimental.6`, bridge `0.3.1-s1.experimental.6` and integration `0.3.1-s1.experimental.6` for Linux amd64. Versions and the default-off relay option are owner approved. The runtime and integration prereleases are published; see the verified links below.

The code payload is identical to review.9: 179 SDK dist files, 15 bridge source modules and server.mjs. Both installed package objects change only their version. Current source packaging commit is `c254aac11d4ad8e599cd14fa89e5e47e33264516`; integration commit is `071c55bf4a9f606eea7603ff3946a52965b2e774`. Its ZIP is 526898 bytes, SHA-256 `23d90f50a19494d411f071864dd40122bcc8ef47468d5b949e669cc1b0f99154`.

Native live view runs in Home Assistant's player when `webrtc_relay` is set to boolean `true` and the add-on is restarted; the integration selects it automatically. The option defaults to `false`; false, absent and non-boolean values override inherited relay enablement to zero. Image command-session keepalive stays 29000 ms independently. Update both the add-on and integration, and turn off Preload camera stream for battery cameras.

This refresh includes the battery-camera stream fix, floodlight late-reply handling with bounded automatic state correction, supported S1 camera sirens, standard doorbell ring events and faster live-view admission. A slow camera may fail at 15 seconds on its first live-view attempt; retry. Doorbell presses may arrive more than once, and live view takes a few seconds to release. Experimental status remains.

The overlay uses the exact immutable experimental.4 digest used by review.9, rather than the earlier candidate's experimental.5 base. The complete code overlay includes the later fixes; native, Go, OS and launcher dependencies are inherited. Configurable startup and release/source metadata intentionally differ from review.9. Full image equivalence and physical-device acceptance are not asserted.

Current source/license records replace stale inherited records in /app, its SDK package and /usr/share/licenses/eufy. Historical base recipe/source chain remains preserved; current recipe/manifest is installed separately under /recipe/experimental6. Trial image results are recorded separately. Release assets and registry image are independently verified. Installation, exact-image hardware, HA/HACS and soak acceptance remain separate. No package installation occurs in this overlay.

The current recipe is `packaging/experimental6-overlay.Dockerfile`; `packaging/EXPERIMENTAL6_OVERLAY.json` hashes every root input. The manifest and recipe are copied independently outside root to avoid a self-hash cycle. Historical top-level Dockerfile and image-input lock remain historical. Companion integration is delivered separately, never installed by the image. Keep the workflow disabled until an explicitly approved publication.

Verified runtime/source release: https://github.com/genomez/ha-eufy-sdk-addon/releases/tag/s1-runtime-0.4.1.experimental.6

Verified companion integration release: https://github.com/genomez/ha-eufy-sdk/releases/tag/0.3.1-s1.experimental.6
