import assert from "node:assert/strict";
import { EufyMega } from "@mega-yfue/eufy-sdk";
import * as native from "node-datachannel";
assert.equal(typeof EufyMega, "function");
assert.equal(typeof (native.PeerConnection ?? native.default?.PeerConnection), "function");
console.log(JSON.stringify({ event: "package_import", sdk: true, rtc_native: true, architecture: process.arch }));
