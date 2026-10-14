import fs from "node:fs";
import path from "node:path";
import crypto from "node:crypto";
import { execFileSync } from "node:child_process";

const hash = bytes => crypto.createHash("sha256").update(bytes).digest("hex");
const lock = JSON.parse(fs.readFileSync(new URL("./image-inputs.lock.json", import.meta.url)));
const mode = process.argv[2];
const check = (file, expected) => {
  if (fs.lstatSync(file).isSymbolicLink() || hash(fs.readFileSync(file)) !== expected) throw new Error("Input digest mismatch: " + path.basename(file));
};
if (mode === "pair") {
  check("/artifacts/eufy-sdk-local.tgz", lock.sdk.sha256);
  check("/app/package.json", lock.bridge.packageJsonSha256);
  check("/app/package-lock.json", lock.bridge.packageLockSha256);
  const pair = JSON.parse(fs.readFileSync("/app/package-lock.json"));
  const sdk = pair.packages["node_modules/@mega-yfue/eufy-sdk"];
  const integrity = "sha512-" + crypto.createHash("sha512").update(fs.readFileSync("/artifacts/eufy-sdk-local.tgz")).digest("base64");
  if (sdk.resolved !== "file:../artifacts/eufy-sdk-local.tgz" || sdk.integrity !== integrity) throw new Error("SDK pairing mismatch");
} else if (mode === "sdk") {
  const root = "/app/node_modules/@mega-yfue/eufy-sdk";
  const actual = [];
  function walk(dir) {
    for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
      const p = path.join(dir, entry.name);
      if (entry.isDirectory()) walk(p);
      else if (entry.isFile()) actual.push(path.relative(root, p).split(path.sep).join("/"));
      else throw new Error("Unexpected installed SDK link");
    }
  }
  walk(root);
  if (JSON.stringify(actual.sort()) !== JSON.stringify(Object.keys(lock.sdk.installedFiles).sort())) throw new Error("Installed SDK inventory mismatch");
  for (const [name, expected] of Object.entries(lock.sdk.installedFiles)) check(path.join(root, name), expected);
} else if (mode === "debs") {
  const files = fs.readdirSync("/os-debs").sort();
  if (JSON.stringify(files) !== JSON.stringify(lock.debian.packages.map(item => item.file).sort())) throw new Error("OS archive inventory mismatch");
  for (const item of lock.debian.packages) {
    const file = path.join("/os-debs", item.file);
    check(file, item.sha256);
    const fields = Object.fromEntries(execFileSync("dpkg-deb", ["-f", file, "Package", "Version", "Architecture"], { encoding: "utf8" }).trim().split("\n").map(line => {
      const colon = line.indexOf(":");
      return [line.slice(0, colon), line.slice(colon + 1).trim()];
    }));
    if (fields.Package !== item.name || fields.Version !== item.version || fields.Architecture !== item.architecture) throw new Error("OS archive metadata mismatch");
  }
} else if (mode === "os") {
  const installed = new Map(execFileSync("dpkg-query", ["-W", "-f=${Package} ${Version}\n"], { encoding: "utf8" }).trim().split("\n").map(line => line.split(" ")));
  const expected = new Map(lock.basePackages.map(item => [item.name, item.version]));
  for (const item of lock.debian.packages) expected.set(item.name, item.version);
  if (installed.size !== expected.size) throw new Error("OS package inventory mismatch");
  for (const [name, version] of expected) if (installed.get(name) !== version) throw new Error("OS package version mismatch: " + name);
} else if (mode === "go2rtc") {
  check("/usr/local/bin/go2rtc", lock.go2rtc.sha256);
} else {
  throw new Error("Unknown input verification mode");
}
console.log(JSON.stringify({ event: "build_inputs_verified", mode }));
