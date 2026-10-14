# Installer and exact runtime recipe

The current installer metadata is `eufy_sdk_s1/config.yaml`, version
`0.4.1-s1.experimental.2`. Use only an owner-approved local bundle or an exact
matching published image with its checksum, registry manifest/config identity
verification and all corresponding-source assets. `CANDIDATE.json` binds the
exact local runtime config ID and source assets. A config ID is distinct from a
registry manifest digest; the latter must be established during publication.

`CANDIDATE.json` is a preparation-time receipt. Its unpublished/not-installed status and null registry fields describe that preparation checkpoint, not future artifact availability. A later publication supplies a separate receipt binding the registry manifest, exact config/layers and independently verified corresponding-source downloads; consult that matching publication receipt as well as this preparation record.

The authoritative updated runtime recipe is `container/Dockerfile` in the safety
source kit and `final-context.tar`. Its default base is the immutable published
manifest recorded in `BASE_BINDING.json`. The offline driver asserts that base's
local config ID/RepoDigest before using an explicit local override. The original
complete base build recipe, SDK/bridge source kit, source-built native/Go inputs,
and OS/Node corresponding-source archives also accompany delivery, so rebuilding
does not depend only on an opaque runtime image.

Historical root preview Dockerfile/example/packaging files are excluded from this
installer export. The source-repository publication workflow is excluded from the
installation archive and remains unchanged in the published repository. Preserve
it when applying a future approved source patch. No npm publication is intended;
the exact SDK/bridge local tarballs belong in the corresponding-source delivery.

All prior runtime options/defaults, add-on slug and launcher remain. Identity and
Supervisor-discovery migration are deferred. The integration does not add a
Supervisor discovery handler. Follow the existing single-entry reconfiguration
and private backup/rollback procedure only within a separately approved window.
Six existing Core overlays are separate; synthetic qualification does not accept
stock-Core playback, Supervisor installation, physical-camera behavior or camera
switching. Preserve the SDK Apache-2.0 and all dependency/native/Go/OS notices.
