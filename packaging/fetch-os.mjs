import fs from "node:fs";
import path from "node:path";
import crypto from "node:crypto";
import { fileURLToPath } from "node:url";

export async function fetchVerified(item, fetcher = fetch) {
  let url = new URL(item.url);
  for (let hop = 0; hop <= 5; hop++) {
    if (url.protocol !== "https:" || url.hostname !== "snapshot.debian.org" || url.username || url.password || url.port) throw new Error("Unexpected package source");
    const response = await fetcher(url, { signal: AbortSignal.timeout(90000), redirect: "manual" });
    if ([301, 302, 303, 307, 308].includes(response.status)) {
      const destination = response.headers.get("location");
      await response.body?.cancel();
      if (!destination || hop === 5) throw new Error("Public dependency redirect limit");
      url = new URL(destination, url);
      continue;
    }
    if (!response.ok || !response.body) throw new Error("Public dependency download failed");
    const reader = response.body.getReader();
    const chunks = [];
    let size = 0;
    for (;;) {
      const { done, value } = await reader.read();
      if (done) break;
      size += value.length;
      if (size > item.bytes) {
        await reader.cancel();
        throw new Error("Public dependency size exceeded");
      }
      chunks.push(Buffer.from(value));
    }
    const bytes = Buffer.concat(chunks);
    if (size !== item.bytes || crypto.createHash("sha256").update(bytes).digest("hex") !== item.sha256) throw new Error("Public dependency digest mismatch");
    return bytes;
  }
  throw new Error("Public dependency redirect limit");
}

if (process.argv[1] && path.resolve(process.argv[1]) === fileURLToPath(import.meta.url)) {
  const lock = JSON.parse(fs.readFileSync(new URL("./image-inputs.lock.json", import.meta.url)));
  const output = process.argv[2];
  if (!output || process.arch !== "x64" || process.platform !== "linux") throw new Error("Unsupported build platform");
  fs.mkdirSync(output, { recursive: true });
  let completed = 0;
  for (const item of lock.debian.packages) {
    if (path.basename(item.file) !== item.file || !item.file.endsWith(".deb")) throw new Error("Invalid package path");
    const bytes = await fetchVerified(item);
    fs.writeFileSync(path.join(output, item.file), bytes, { flag: "wx" });
    completed++;
  }
  console.log(JSON.stringify({ event: "os_inputs_verified", packages: completed }));
}
