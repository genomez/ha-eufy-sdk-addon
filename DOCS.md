# Installer and exact runtime recipe

The current installer metadata is `eufy_sdk_s1/config.yaml`, version
`0.4.1-s1.experimental.5`. Use only an owner-approved local bundle or an exact
matching published image with its checksum, registry manifest/config identity
verification and all corresponding-source assets. `CANDIDATE.json` binds the
exact local runtime config ID and source assets. A config ID is distinct from a
registry manifest digest; the latter must be established during publication.

`CANDIDATE.json` is a preparation-time receipt. It now records the published experimental.5 image, registry manifest and source commits. The publication receipt binding the registry manifest, exact config/layers and independently verified corresponding-source downloads; consult it together with `PUBLICATION.json`.

The authoritative experimental.5 runtime recipe is the release asset
`final-context.tar`. Its `Dockerfile` starts from the published experimental.4
image `ghcr.io/genomez/eufy-sdk-s1-amd64@sha256:3f28d98fefd9ddab0032921586f2b009e931c841e277a4ebd86a76471444f517`
and adds one replacement layer. It enables command-session keepalive with
`ENV BRIDGE_RTC_COMMAND_KEEPALIVE_MS=29000`. Follow the matching release assets'
`REBUILD.md` for the experimental.4 and experimental.2 corresponding-source
chain, original base recipe, native/Go inputs and OS/Node source archives.

Historical root preview Dockerfile/example/packaging files are excluded from this
installer export. The source-repository publication workflow is excluded from the
installation archive and is retargeted to the exact experimental.5 publication inputs.
No npm publication is intended;
the exact SDK/bridge local tarballs belong in the corresponding-source delivery.

The add-on slug, launcher and user configuration remain. The image now enables
29-second command-session keepalive by default. Identity and
Supervisor-discovery migration are deferred. The integration does not add a
Supervisor discovery handler. Follow the existing single-entry reconfiguration
and private backup/rollback procedure only within a separately approved window.
Six existing Core overlays are separate; synthetic qualification does not accept
stock-Core playback, Supervisor installation, physical-camera behavior or camera
switching. Preserve the SDK Apache-2.0 and all dependency/native/Go/OS notices.
