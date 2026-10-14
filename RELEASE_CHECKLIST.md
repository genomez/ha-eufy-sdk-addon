# Release prerequisites

1. Obtain the owner decision for this exact reviewed runtime/add-on and paired
   integration candidate. Keep SDK/bridge packages as checksum-bound local tarball
   assets; do not publish them to npm.
2. Deliver the exact candidate image archive, final context, updated sources and
   compiler inputs, full base source/build kit and OS/Node corresponding sources.
   Preserve all notices and verify recipient downloads and checksums.
3. If publishing a registry image, bind the registry manifest digest to the exact
   reviewed image config ID and every layer; independently verify anonymous
   download/pull before recommending that version to a tester.
4. Preserve the published source-repository workflow while applying only reviewed
   source and metadata changes. The installation archive intentionally omits it.
5. Use a separately approved installation window with the documented private
   backup, exclusive bridge ownership, migration and rollback checks. Publication
   does not authorize installation, restart or physical-device control.
