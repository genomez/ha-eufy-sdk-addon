# Experimental.8 local preparation

Current pairing: add-on `0.4.1-s1.experimental.8`, integration `0.3.1-s1.experimental.8`, bridge `0.3.1-s1.experimental.8`, SDK `0.2.1-s1.experimental.8`.

Current recipe: `packaging/experimental8-overlay.Dockerfile`. Source input: `b13c23cb3ecc270d07107b726264faea37d998ce`. Integration input: `9dd9c7fb035926000340d14f8134712e215fb32e`. The frozen runtime image and all runtime/source packages are unchanged by this documentation refresh. Relay remains off by default with strict boolean-true opt-in; integration floodlight safety remains off by default.

This preparation is local and unpublished. Public release URLs and registry bindings are supplied later at publication checklist step 9, only after independent anonymous verification. No current public URL is claimed here. Publication, installation and tester messaging each require separate approval.

## Historical experimental.7 and earlier guidance

The following retained text describes .7 and earlier releases. Its pairings, recipe, source inputs, URLs and completed-publication claims are historical and do not describe this unpublished .8 preparation.

# Experimental.7 local preparation

Current pairing: add-on `0.4.1-s1.experimental.7`, integration `0.3.1-s1.experimental.7`, bridge `0.3.1-s1.experimental.7`, SDK `0.2.1-s1.experimental.7`. Runtime delivery: https://github.com/genomez/ha-eufy-sdk-addon/releases/tag/s1-runtime-0.4.1.experimental.7. Integration delivery: https://github.com/genomez/ha-eufy-sdk/releases/tag/0.3.1-s1.experimental.7. Public relay default remains false; opt into live view with `webrtc_relay: true`. Integration owns optional automatic floodlight correction. Runtime source is `6deea127459f368edb24d7d3df59dcaf60d5b508`. Current recipe is `packaging/experimental7-overlay.Dockerfile`; earlier version-specific instructions below are historical. Publication and installation require separate approval.

# Release prerequisites

This published experimental release includes the approved versions and default-off relay. Installation and live acceptance remain separate decisions.

1. Verify the exact trial image, file/hash map, native imports, option propagation and image/archive identities against retained receipts. Preserve qualification limits.
2. Deliver exact current SDK/bridge sources, SDK tarball, integration ZIP, overlay context/recipe and checksum index, plus the complete experimental.4 and experimental.2 corresponding-source chain and OS/Node/native/Go inputs.
3. Only after explicit publication approval, bind the pushed registry manifest to the verified image config and layers, publish matching assets and independently verify anonymous downloads/pulls.
4. The fully bound workflow published the exact accepted image after runtime release/assets verification. Registry verification completed before version/config metadata publication. The accepted context retains its historical disabled template.
5. Installation, restart, private backup, exclusive bridge ownership and physical-device checks require their own approved window. Retain recovery material.

Verified runtime/source release: https://github.com/genomez/ha-eufy-sdk-addon/releases/tag/s1-runtime-0.4.1.experimental.6

Verified companion integration release: https://github.com/genomez/ha-eufy-sdk/releases/tag/0.3.1-s1.experimental.6
