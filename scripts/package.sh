#!/usr/bin/env bash
# Build one zip per skill under dist/, each with the skill folder at the zip root,
# ready to upload in Claude (Customize → Skills → upload).
set -euo pipefail
cd "$(dirname "$0")/.."
rm -rf dist && mkdir -p dist
for dir in skills/*/; do
  name=$(basename "$dir")
  (cd skills && python3 -c "
import sys, zipfile, pathlib
name = sys.argv[1]
with zipfile.ZipFile(f'../dist/{name}.zip', 'w', zipfile.ZIP_DEFLATED) as z:
    for p in sorted(pathlib.Path(name).rglob('*')):
        if p.is_file():
            z.write(p, p.as_posix())
" "$name")
  echo "dist/$name.zip"
done
