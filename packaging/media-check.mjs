import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import { spawnSync } from "node:child_process";

// Generated black frames only. This check never opens the bridge or a device connection.
const root = fs.mkdtempSync(path.join(os.tmpdir(), "media-build-check-"));
function run(file, args) {
  const result = spawnSync(file, args, { timeout: 30000, maxBuffer: 1024 * 1024, encoding: "utf8" });
  if (result.status !== 0 || result.error) throw new Error("Offline media capability check failed: " + file);
  return result.stdout;
}
try {
  const common = ["-hide_banner", "-loglevel", "error", "-threads", "1"];
  for (const [format, codec] of [["h264", "libx264"], ["hevc", "libx265"]]) {
    const filename = path.join(root, "synthetic." + format);
    const extra = codec === "libx265" ? ["-x265-params", "pools=none:frame-threads=1:wpp=0:log-level=error"] : [];
    run("ffmpeg", [...common, "-f", "lavfi", "-i", "color=c=black:s=64x64:r=1", "-frames:v", "1", "-c:v", codec, ...extra, "-f", format, filename]);
    const image = path.join(root, format + ".jpg");
    run("ffmpeg", [...common, "-f", format, "-i", filename, "-frames:v", "1", "-c:v", "mjpeg", "-f", "image2", image]);
    const bytes = fs.readFileSync(image);
    if (bytes[0] !== 0xff || bytes[1] !== 0xd8 || bytes.at(-2) !== 0xff || bytes.at(-1) !== 0xd9) throw new Error("Synthetic JPEG check failed");
  }
  const version = run("go2rtc", ["-version"]).trim();
  if (!version.includes("1.9.9")) throw new Error("go2rtc version mismatch");
  const protocols = run("ffmpeg", ["-hide_banner", "-protocols"]);
  const muxers = run("ffmpeg", ["-hide_banner", "-muxers"]);
  if (!/\bhttp\b/.test(protocols) || !/\bpipe\b/.test(protocols) || !/\brtsp\b/.test(muxers)) throw new Error("Required media protocol absent");
  console.log(JSON.stringify({ event: "offline_media_check", generatedH264: true, generatedHevc: true, decodedJpeg: true, rtspAdvertised: true }));
} finally {
  fs.rmSync(root, { recursive: true, force: true });
}
