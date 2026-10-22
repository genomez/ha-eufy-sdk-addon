# Experimental.7 local preparation

Current pairing: add-on `0.4.1-s1.experimental.7`, integration `0.3.1-s1.experimental.7`, bridge `0.3.1-s1.experimental.7`, SDK `0.2.1-s1.experimental.7`. This release is unpublished. Public relay default remains false; opt into live view with `webrtc_relay: true`. Integration owns optional automatic floodlight correction. Runtime source is `6deea127459f368edb24d7d3df59dcaf60d5b508`. Current recipe is `packaging/experimental7-overlay.Dockerfile`; earlier version-specific instructions below are historical. Publication and installation require separate approval.

# Experimental.6 release

Add-on `0.4.1-s1.experimental.6` pairs SDK `0.2.1-s1.experimental.6`, bridge `0.3.1-s1.experimental.6` and integration `0.3.1-s1.experimental.6` for Linux amd64. Versions and the default-off relay option are owner approved. The runtime and integration prereleases are published; see the verified links below.

The code payload is identical to review.9: 179 SDK dist files, 15 bridge source modules and server.mjs. Both installed package objects change only their version. Current source packaging commit is `c254aac11d4ad8e599cd14fa89e5e47e33264516`; integration commit is `071c55bf4a9f606eea7603ff3946a52965b2e774`. Its ZIP is 526898 bytes, SHA-256 `23d90f50a19494d411f071864dd40122bcc8ef47468d5b949e669cc1b0f99154`.

Native live view runs in Home Assistant's player when `webrtc_relay` is set to boolean `true` and the add-on is restarted; the integration selects it automatically. The option defaults to `false`; false, absent and non-boolean values override inherited relay enablement to zero. Image command-session keepalive stays 29000 ms independently. Update both the add-on and integration, and turn off Preload camera stream for battery cameras.

This refresh includes the battery-camera stream fix, floodlight late-reply handling with bounded automatic state correction, supported S1 camera sirens, standard doorbell ring events and faster live-view admission. A slow camera may fail at 15 seconds on its first live-view attempt; retry. Doorbell presses may arrive more than once, and live view takes a few seconds to release. Experimental status remains.

The overlay uses the exact immutable experimental.4 digest used by review.9, rather than the earlier candidate's experimental.5 base. The complete code overlay includes the later fixes; native, Go, OS and launcher dependencies are inherited. Configurable startup and release/source metadata intentionally differ from review.9. Full image equivalence and physical-device acceptance are not asserted.

Current source/license records replace stale inherited records in /app, its SDK package and /usr/share/licenses/eufy. Historical base recipe/source chain remains preserved; current recipe/manifest is installed separately under /recipe/experimental6. Trial image results are recorded separately. Release assets and registry image are independently verified. Installation, exact-image hardware, HA/HACS and soak acceptance remain separate. No package installation occurs in this overlay.

Verified runtime/source release: https://github.com/genomez/ha-eufy-sdk-addon/releases/tag/s1-runtime-0.4.1.experimental.6

Verified companion integration release: https://github.com/genomez/ha-eufy-sdk/releases/tag/0.3.1-s1.experimental.6
