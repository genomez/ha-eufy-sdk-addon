# S1 experimental.9 — Update checklist

Home Assistant add-on containing the paired bridge and SDK runtime. Update the add-on and integration together.

Pair add-on `0.4.1-s1.experimental.9`, integration/bridge `0.3.1-s1.experimental.9` and SDK `0.2.1-s1.experimental.9`.

Check the paired versions, verify the integration ZIP checksum, update both components, restart Home Assistant after replacing integration files, and check logs. Live-view opt-in requires an add-on restart. Keep battery-camera preload off.

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
