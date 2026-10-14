# Packaging source preview

Read [EXPERIMENTAL.md](EXPERIMENTAL.md) first. This branch is not an add-on repository for installation. The retained Dockerfile and exact-input assembler document the privately qualified Linux amd64 recipe; they require paired artifacts which are not supplied as a public release.

The recipe uses a digest-pinned Node/Debian base, pinned OS archives, the paired SDK and bridge, and go2rtc. It excludes runtime options, sessions, captures and home configuration from build contexts. The public source preview contains no built image or native binary. Historical private qualification is not a claim of a newly built image from this publication tree.

The copied SDK notice and current SDK package LICENSE are Apache-2.0. An earlier private review note claiming a mismatch was incorrect. Preserve all component notices. Native binary provenance and corresponding-source delivery for the final binary set still need resolution before an image release. No image publishing workflow is enabled here.

The integration and add-on do not install or patch Core. External Core modifications used during private streaming qualification are not included, and stock-Core streaming is unverified. Repository/slug migration, complete install instructions, upgrade and rollback acceptance remain pending for an installable release.

`config.yaml.example` preserves reference configuration without exposing a discoverable app in this source-preview branch. It is not a migration or installation instruction.
