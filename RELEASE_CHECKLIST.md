# Experimental.7 local preparation

Current pairing: add-on `0.4.1-s1.experimental.7`, integration `0.3.1-s1.experimental.7`, bridge `0.3.1-s1.experimental.7`, SDK `0.2.1-s1.experimental.7`. This release is unpublished. Public relay default remains false; opt into live view with `webrtc_relay: true`. Integration owns optional automatic floodlight correction. Runtime source is `6deea127459f368edb24d7d3df59dcaf60d5b508`. Current recipe is `packaging/experimental7-overlay.Dockerfile`; earlier version-specific instructions below are historical. Publication and installation require separate approval.

# Release prerequisites

This published experimental release includes the approved versions and default-off relay. Installation and live acceptance remain separate decisions.

1. Verify the exact trial image, file/hash map, native imports, option propagation and image/archive identities against retained receipts. Preserve qualification limits.
2. Deliver exact current SDK/bridge sources, SDK tarball, integration ZIP, overlay context/recipe and checksum index, plus the complete experimental.4 and experimental.2 corresponding-source chain and OS/Node/native/Go inputs.
3. Only after explicit publication approval, bind the pushed registry manifest to the verified image config and layers, publish matching assets and independently verify anonymous downloads/pulls.
4. The fully bound workflow published the exact accepted image after runtime release/assets verification. Registry verification completed before version/config metadata publication. The accepted context retains its historical disabled template.
5. Installation, restart, private backup, exclusive bridge ownership and physical-device checks require their own approved window. Retain recovery material.

Verified runtime/source release: https://github.com/genomez/ha-eufy-sdk-addon/releases/tag/s1-runtime-0.4.1.experimental.6

Verified companion integration release: https://github.com/genomez/ha-eufy-sdk/releases/tag/0.3.1-s1.experimental.6
