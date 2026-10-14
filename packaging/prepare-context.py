"""Assemble an explicit, hash-checked build context without importing runtime state."""
from pathlib import Path
import argparse
import hashlib
import json
import tarfile
import stat

RECIPE_FILES = ["Dockerfile", ".dockerignore", "packaging/image-inputs.lock.json",
                "packaging/fetch-os.mjs", "packaging/verify-inputs.mjs", "packaging/media-check.mjs"]


def digest(data):
    return hashlib.sha256(data).hexdigest()


def relative_name(name):
    if not isinstance(name, str) or not name or "\\" in name or ":" in name or "\x00" in name:
        raise ValueError("Invalid relative input path")
    if any(part in ["", ".", ".."] for part in name.split("/")):
        raise ValueError("Invalid relative input path")
    return name


def no_links(path):
    absolute = path.absolute()
    for item in [*reversed(absolute.parents), absolute]:
        if not item.exists() and not item.is_symlink():
            continue
        info = item.lstat()
        if stat.S_ISLNK(info.st_mode) or getattr(info, "st_file_attributes", 0) & getattr(stat, "FILE_ATTRIBUTE_REPARSE_POINT", 0):
            raise ValueError("Linked or reparse-point path is not allowed")
    return absolute


def checked(path, expected):
    no_links(path)
    if path.is_symlink() or not path.is_file():
        raise ValueError("Input must be a regular file: " + path.name)
    data = path.read_bytes()
    if digest(data) != expected:
        raise ValueError("Input hash mismatch: " + path.name)
    return data


def assemble(addon, bridge, pair, sdk, go2rtc, output, output_root):
    for root in [addon, bridge, pair, output_root]:
        no_links(root)
        if not root.is_dir():
            raise ValueError("Input/output root must already be a directory")
    output = no_links(output)
    if output.parent != output_root.absolute() or output.name in ["", ".", ".."]:
        raise ValueError("Output must be a new direct child of the chosen output root")
    no_links(addon / "packaging/image-inputs.lock.json")
    lock = json.loads((addon / "packaging/image-inputs.lock.json").read_text())
    if output.exists():
        raise ValueError("Output must be a new directory")
    payload = {}
    for name, expected in lock["addonSourceFiles"].items():
        relative_name(name)
        payload[name] = checked(addon / name, expected)
    for name in RECIPE_FILES:
        relative_name(name)
        path = no_links(addon / name)
        if not path.is_file():
            raise ValueError("Recipe input must be a regular file")
        payload[name] = path.read_bytes()
    for name, expected in lock["bridge"]["runtimeFiles"].items():
        relative_name(name)
        payload["bridge/" + name] = checked(bridge / name, expected)
    for name, key in [("package.json", "packageJsonSha256"), ("package-lock.json", "packageLockSha256")]:
        payload["pair/" + name] = checked(pair / name, lock["bridge"][key])
    payload["artifacts/eufy-sdk-local.tgz"] = checked(sdk, lock["sdk"]["sha256"])
    payload["artifacts/go2rtc_linux_amd64"] = checked(go2rtc, lock["go2rtc"]["sha256"])
    # Archive paths are checked without extracting any untrusted members.
    with tarfile.open(sdk) as archive:
        actual = {}
        for member in archive:
            if not member.isfile() or not member.name.startswith("package/") or ".." in Path(member.name).parts:
                raise ValueError("Unexpected SDK archive member")
            name = relative_name(member.name.removeprefix("package/"))
            if name in actual:
                raise ValueError("Duplicate SDK archive member")
            actual[name] = digest(archive.extractfile(member).read())
        if actual != lock["sdk"]["installedFiles"]:
            raise ValueError("SDK archive inventory mismatch")
    transformed = []
    for name, data in payload.items():
        if name.endswith(".sh") and b"\r\n" in data:
            normalized = data.replace(b"\r\n", b"\n")
            transformed.append({"path": name, "sourceSha256": digest(data), "contextSha256": digest(normalized), "kind": "CRLF to LF"})
            payload[name] = normalized
    manifest = {"schemaVersion": 1, "files": {name: digest(data) for name, data in sorted(payload.items())},
                "transformations": transformed, "includesCorePatches": False, "includesRuntimeState": False}
    payload["CONTEXT_MANIFEST.json"] = (json.dumps(manifest, indent=2) + "\n").encode()
    output.mkdir(parents=True, exist_ok=False)
    for name, data in payload.items():
        target = output / name
        target.parent.mkdir(parents=True, exist_ok=True)
        target.write_bytes(data)
    actual = {p.relative_to(output).as_posix(): digest(p.read_bytes()) for p in output.rglob("*") if p.is_file()}
    if actual != {name: digest(data) for name, data in payload.items()}:
        raise ValueError("Context read-back mismatch")
    return manifest


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--bridge", type=Path, required=True)
    parser.add_argument("--pair", type=Path, required=True)
    parser.add_argument("--sdk", type=Path, required=True)
    parser.add_argument("--go2rtc", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--output-root", type=Path, required=True)
    args = parser.parse_args()
    result = assemble(Path(__file__).resolve().parents[1], args.bridge, args.pair, args.sdk, args.go2rtc, args.output, args.output_root)
    print(json.dumps({"files": len(result["files"]) + 1, "shellNormalizations": len(result["transformations"]), "imageBuilt": False}))
