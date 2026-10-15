# 0.4.1-s1.experimental.4 experimental

SDK `0.2.1-s1.experimental.4` and bridge `0.3.1-s1.experimental.4`, paired with integration `0.3.1.dev2`.

- Each SDK error report now carries a fixed origin label. The bridge's cached `sdkErrors` diagnostics add `lastOrigin`, per-origin counts and the last 10 errors (time, type and origin only; no error text or identifiers).
- Session renewal retries once, after a 30-second cooldown, when a verified replacement times out while the old session is briefly busy (from the unpublished experimental.3).

Runtime options and defaults are unchanged. Not yet tested on physical hardware. Runtime and sources: https://github.com/genomez/ha-eufy-sdk-addon/releases/tag/s1-runtime-0.4.1.experimental.4

# 0.4.1-s1.experimental.2 experimental

The SDK local ICE callback sends only while its signaling socket is open. The paired integration candidate adds detection-mask safety. Bridge implementation, runtime options/defaults, native/Go/OS artifacts, launcher and add-on identity remain. Exact base-plus-patch source and package bindings accompany the runtime. Supervisor installation, stock-Core media and physical-device acceptance remain separate.

# 0.4.1-s1.experimental.1 experimental

Separate S1 experimental add-on identity and prebuilt-image metadata around the retained synthetic-qualified amd64 container; [runtime archive and corresponding sources](https://github.com/genomez/ha-eufy-sdk-addon/releases/tag/s1-runtime-0.4.1.experimental.1). SDK/bridge runtime sources are unchanged from the reviewed source preview. Added migration, single integration ownership, private-data and rollback instructions. Registry digest/anonymous-pull verification is recorded separately in CANDIDATE.json. Supervisor migration, HACS replacement UI, stock-Core media, camera switching and physical-device acceptance remain unverified.
