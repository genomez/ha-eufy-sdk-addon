# S1 experimental.9 — Updating from experimental.8

Home Assistant add-on containing the paired bridge and SDK runtime. Update the add-on and integration together.

Pair add-on `0.4.1-s1.experimental.9`, integration/bridge `0.3.1-s1.experimental.9` and SDK `0.2.1-s1.experimental.9`.

Update both components. Existing experimental.8 option defaults are retained. Automations selecting night-vision Full Color must use Spotlights; hub reply attributes are last_hub_offline_reply and hub_offline_reply_count.

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

# Migration and rollback contract

Published experimental.6: exact image, source and release identities are bound in CANDIDATE.json. Installation and live acceptance remain separate. Do not use the procedure until exact approved artifacts and qualification are available. Integration release URL: `https://github.com/genomez/ha-eufy-sdk/releases/tag/0.3.1-s1.experimental.6`.

## Safety release pairing and legacy integration users

For add-on `0.4.1-s1.experimental.6`, use integration `0.3.1-s1.experimental.6`.
The steps below that mention Reconfigure apply only to an existing `eufy_sdk`
entry. Users coming from the legacy `eufy_security` WebSocket stack must retain
their old files and entry for recovery, disable the old entry during the trial,
and create a separate `eufy_sdk` entry. Do not redirect legacy Reconfigure to the
SDK bridge or run old and new bridges concurrently. Fresh SDK authentication may
invalidate the old session; recovery may require signing in again. Preserve a
completed downloaded HA backup and the original recovery archives before changes.
Follow the separately agreed tester instructions before starting the add-on.


This procedure applies to the exact matching experimental installer and checksum-bound runtime/source assets recorded in `CANDIDATE.json`. Use an owner-approved local bundle or a verified published release. Complete installation, Supervisor migration and physical-device acceptance remain separate owner-controlled steps; keep verified recovery copies and stop if an indispensable gate is incomplete.

## Preserve ownership and recovery

1. Privately record the existing integration entry ID, endpoint and options, installed integration version, add-on identity/image and source, and HACS repository ownership. Save a verified HA backup that includes the existing add-on's private data and integration configuration. Separately retain the old custom integration files and a recoverable copy of its exact container image; a registry-backed add-on backup may not contain that image. Keep recovery material off public GitHub.
2. Preserve the original add-on and its data until acceptance. Do not uninstall it, delete the integration entry, edit `.storage`, rename session files or overwrite the only recovery copy. Check that the backup can be located and read before cutover.
3. Only one implementation may own `custom_components/eufy_sdk`. HACS must not manage upstream and fork copies of that same domain concurrently. Changing HACS repository ownership must preserve the HA integration entry. If the HACS UI cannot do that clearly, use the verified manual integration ZIP and leave HACS reconciliation pending; do not delete/re-add the HA entry to make HACS happy.

## Cutover

1. Within the agreed maintenance window, close live views and stop recordings that may be interrupted. Disable automatic start/watchdog or other known recovery automation for the old bridge, stop it, and verify its process is stopped. Take a verified, coherent stopped-state backup of its private data. An ordinary hot backup is not a substitute for that migration snapshot. Do not start the new bridge until exclusivity is established.
2. Add `https://github.com/genomez/ha-eufy-sdk-addon#s1-experimental` through Supervisor's add-on repository controls and install **Eufy SDK S1 experimental**, version `0.4.1-s1.experimental.6`, architecture amd64. Verify the image tag/digest against `CANDIDATE.json` before starting; repository addition alone is not image verification. Keep it stopped while configuring, with watchdog and automatic updates disabled for the trial. Its private `/data` is separate. This first migration path uses fresh private account configuration and explicit user authentication; it does not bulk-copy old `/data` or create two processes sharing a session. Check the old bridge's authentication policy state first: an active hold/cooldown is a checkpoint, not permission to bypass it with a new data directory or fresh login. Fresh authentication can affect an older session, so retain a rollback reauthentication plan. Verify private directory/file ownership and restrictive permissions on Supervisor's actual data mount; image build-time permissions alone do not establish those mount permissions.
3. Replace the single integration directory with the verified integration `0.3.1-s1.experimental.6` ZIP (`https://github.com/genomez/ha-eufy-sdk/releases/tag/0.3.1-s1.experimental.6`), preserving its `eufy_sdk` domain, and restart Core to load it. Retain the old files outside the active custom-components path. Do not install the local Core overlays as part of this package. An existing locally modified Core remains modified; this procedure does not claim to normalize it.
4. Start the new add-on once. Use the hostname actually reported by Supervisor and port 3000 in the existing integration entry's **Reconfigure** flow. Complete explicit 2FA/CAPTCHA only if requested. The candidate flow must validate before updating the existing entry and must reject an endpoint already owned by another entry. If Reconfigure is unavailable, validation fails or the expected entry is missing, stop here rather than create another entry.
5. Verify the original entry ID and entity/device identities remain, and confirm the expected account's devices in the private UI. Endpoint validation does not prove account identity. If the device inventory is unexpected, stop the new bridge and investigate privately. Do not accept a different account merely because authentication succeeded.
6. Verify cached health and fresh ordinary reads. Run only the agreed controlled playback acceptance, then verify streams end. Preserve failures. Synthetic packaging tests alone do not establish stock-Core playback or S1 runtime acceptance. Enable automatic start for the new add-on only after the chosen acceptance criteria pass; leave the old one stopped.

## Rollback

1. Stop the new add-on and disable its automatic start/watchdog before touching the old one. Confirm the new process is stopped. Keep failure evidence private and bounded.
2. If the new integration is functioning, use its Reconfigure flow to return the existing entry to the recorded old endpoint after the old bridge is started. Authenticate explicitly if its saved session is no longer valid. Verify the same entry ID and the complete original title, data, unique ID and options against the private baseline; reconfiguration sets a generated title and does not preserve a custom title automatically. Follow the integration package's `INSTALL.md` rollback procedure. If any baseline field differs, use the coherent backup fallback below rather than claim exact restoration. If the complete baseline matches, restore the backed-up old integration files and restart Core if reverting that component. Never delete the entry to repair a mismatch.
3. If reconfiguration or the UI is unusable, use the verified HA backup recovery path that restores the old integration configuration, files and add-on data together. Restoring a backup may start an add-on that was running when backed up; ensure the new bridge cannot run first. Have the exact old image available instead of relying on a moving registry tag. Do not selectively hand-edit registry or session storage.
4. Confirm only the old bridge is running, its endpoint is restored, ordinary reads resume and entity IDs remain. Restore its previous automatic-start settings only after that check. Keep the new candidate stopped and retained for diagnosis; recovery is not evidence that the candidate passed.

A later private-session migration tool needs a separate compatibility and permissions check, including Eufy session, FCM identity and authentication-recovery hold state. It is not included here. Never publish or casually transplant those files, and do not assume old `persistent.json` is interchangeable with the current session format.

Current pairing: integration `0.3.1-s1.experimental.6`, ZIP SHA-256 `23d90f50a19494d411f071864dd40122bcc8ef47468d5b949e669cc1b0f99154`. Update both components. The relay defaults to false; set `webrtc_relay: true` and restart the add-on to opt in. The integration selects native live view automatically. Turn off Preload camera stream for battery cameras.

Verified runtime/source release: https://github.com/genomez/ha-eufy-sdk-addon/releases/tag/s1-runtime-0.4.1.experimental.6

Verified companion integration release: https://github.com/genomez/ha-eufy-sdk/releases/tag/0.3.1-s1.experimental.6
