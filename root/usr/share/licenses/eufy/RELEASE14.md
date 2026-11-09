# S1 experimental.14

Pair: add-on **0.4.1-s1.experimental.14**, integration/bridge **0.3.1-s1.experimental.14**, SDK **0.2.1-s1.experimental.14**.

## Fixed
- S350 (T8416) cameras no longer show a spotlight switch they don't have.
- A push connection that silently stops delivering events is now detected and reconnected.
- Camera settings are no longer overwritten by older values when a startup or refresh overlaps a change.
- Snapshot refreshes are no longer lost when they overlap; queued refreshes stop after a sign-in failure.

## Changed
- Floodlight brightness/spotlight controls that HomeBase S1 can't drive are hidden.
- Number settings use per-model ranges.
- Media → Eufy shows "Playback not yet supported for this camera", "No playable recordings yet" or "No recordings yet" instead of an empty camera folder.
- More playback diagnostics.

## Upgrade
Update the add-on and integration together, then restart Home Assistant after the add-on is running, so removed controls are cleaned up.

## Known limits
Playback is silent; multi-lens cameras show one view; a late update from a camera can still briefly show an old state.

The retained TEST_BUILD.json describes the earlier test build. Release identity is recorded separately.
