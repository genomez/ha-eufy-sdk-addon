# Eufy S1 experimental add-on installer

Experimental installer `0.4.1-s1.experimental.1` uses the exact prebuilt amd64 image identified in `CANDIDATE.json`. The [paired runtime/source release](https://github.com/genomez/ha-eufy-sdk-addon/releases/tag/s1-runtime-0.4.1.experimental.1) supplies its image archive, build context, corresponding sources and notices. Before installation, require the completed registry manifest digest, independent anonymous-pull verification and source-download checks in that release record; stop if any are pending. Publication is separate from installation and live acceptance.

The experimental add-on runs the experimental bridge on Linux amd64. It is one component of the stack: Home Assistant also needs the matching fork integration in its single `custom_components/eufy_sdk` directory. The SDK is included in the bridge image. Do not run a standalone bridge container and this add-on against the same account at the same time.

The canonical Supervisor repository URL is:

`https://github.com/genomez/ha-eufy-sdk-addon#s1-experimental`

Use that exact URL consistently. Supervisor includes the repository URL in its repository identity; changing its branch fragment or spelling can create a different add-on and private data directory. The app is located in `eufy_sdk_s1/`, uses slug `eufy_sdk_s1`, starts manually by default, and publishes no host ports by default.

Install the matching [integration prerelease `0.3.1.dev1`](https://github.com/genomez/ha-eufy-sdk/releases/tag/0.3.1.dev1) using its one-owner and backup checkpoints. This fork is independently maintained by `genomez`, derived from the [upstream add-on](https://github.com/mega-yfue/ha-eufy-sdk-addon) and [S1 work](https://github.com/danymexi/eufy-sdk); existing licenses are preserved.

Read [migration and rollback](MIGRATION.md), [configuration](eufy_sdk_s1/DOCS.md), and [release gates](RELEASE_CHECKLIST.md). No six local Core overlays, personal dashboard, account/session files, household identifiers, recordings or diagnostic logs are included.

Synthetic container/media qualification passed for the exact candidate. Stock-Core browser playback, camera switching and a complete Supervisor migration have not been accepted. Do not interpret source availability or an image tag as hardware acceptance.
