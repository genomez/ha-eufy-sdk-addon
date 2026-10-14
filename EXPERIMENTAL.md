# Experimental runtime and installer

This branch supplies the experimental amd64 installer `0.4.1-s1.experimental.1` and frozen image recipe. The [runtime/source release](https://github.com/genomez/ha-eufy-sdk-addon/releases/tag/s1-runtime-0.4.1.experimental.1) carries exact image/source/notices artifacts. Use only the completed registry/source verification in [CANDIDATE.json](CANDIDATE.json); pending verification is a stop checkpoint. Publication is separate from installation and live acceptance; this is not a supported general installation.

The source is a composite S1/T9000 baseline, not a byte-equivalent copy of an official upstream version. Inherited SDK/bridge version fields identify historical preparation inputs; installer/runtime release records identify the exact experimental distribution. Existing contribution branches and upstream history remain separate.

## Scope and evidence

The private qualification target was Linux amd64. ARM and non-S1 operation are not supported by this preview. Source and offline test results are distinct from installation and physical-device acceptance.

The prepared SDK suite passed 4,946 tests and the bridge suite passed 95 tests. Integration qualification included 220 test items plus 155 subtests and a separate 16-case native framework suite. These are retained pre-publication qualification results, not checks newly run by public CI on this branch. Publication metadata and documentation edits are reviewed separately.

The private bridge installation completed and basic single-camera playback worked. Camera switching and intermittent frontend resets remain unresolved. A lifecycle trace observed an active player element being replaced by a new element; the trigger is not yet identified. Reported light state has also differed from observed physical state.

The tested streaming environment used six separate, version-specific Home Assistant Core modifications on a 2026.10.1 basis. They are not bundled here. Stock-Core streaming compatibility is unverified. Do not overwrite Core files or assume an ordinary HACS install recreates that environment. The optional player assets are not automatically registered or added to dashboards.

## Installation boundary

Installation requires the [migration/rollback contract](MIGRATION.md) and matching [integration `0.3.1.dev1` checkpoints](https://github.com/genomez/ha-eufy-sdk/blob/0.3.1.dev1/INSTALL.md). The integration retains `eufy_sdk` and one HACS/manual file owner; preserve the existing HA entry. Keep the exact old component, image and coherent private configuration/data snapshot. The new repository/slug has separate private data and does not automatically migrate sessions; complete Supervisor migration has not been accepted.

The bridge's historical registry SDK dependency is not the customized SDK used during qualification. Running `npm ci` in the bridge alone does not produce the qualified component pair. The exact paired image/build inputs, dependency/native notices and corresponding sources are supplied through the runtime/source release. Verify their concrete URLs and retained checksums. The nested prebuilt installer has no local build fallback; do not use a root source rebuild as an unreviewed replacement image.

Release automation publishes only the reviewed exact image/artifact set through its separate release process. Dependency provenance and corresponding-source/notices receipts accompany the runtime release; they do not establish device, Supervisor migration or stock-Core acceptance. Existing licenses and upstream credit are preserved.

## Contributing useful findings

Source reviews, synthetic reproductions and narrowly scoped fixes are welcome. For a bug report, include the component commit, model numbers (not serial numbers), software versions, power type, connection topology in general terms, reproduction steps, and expected versus observed behavior.

Do not post credentials, tokens, session files, account identifiers, device serials, P2P identifiers, personal names, home addresses, IP/MAC/SSID values, household dashboards, camera images, packet captures or raw logs. Start with a short redacted description. Use synthetic fixtures for code and tests. Keep private recovery material outside repositories and build contexts.

Fixes should retain explicit stream start/stop, cleanup on navigation/removal/visibility changes, and ordinary state-read/session-renewal behavior. No automatic retries or hidden camera starts should be added to hide a failure.

Target contributions at `s1-experimental`. Existing default-branch workflows and support claims are separate from this experimental release.
