#!/usr/bin/env bash
set -euo pipefail
SPDX_LINE="SPDX-License-Identifier: Apache-2.0"
# ekstenzije i njihov komentar prefix
declare -A prefix
prefix=( [".py"]="# " [".js"]="// " [".ts"]="// " [".go"]="// " )

for ext in "${!prefix[@]}"; do
  find . -type f -name "*${ext}" ! -path "./.git/*" | while read -r file; do
    if grep -q "SPDX-License-Identifier" "$file"; then
      continue
    fi
    # izbaci shebang ako postoji
    firstline=$(head -n1 "$file" || true)
    tmpfile="${file}.spdx.tmp"
    if [[ "$ext" == ".py" && "$firstline" =~ ^#! ]]; then
      printf "%s\n" "$firstline" > "$tmpfile"
      printf "# %s\n" "$SPDX_LINE" >> "$tmpfile"
      tail -n +2 "$file" >> "$tmpfile"
    else
      printf "%s%s\n" "${prefix[$ext]}" "$SPDX_LINE" > "$tmpfile"
      cat "$file" >> "$tmpfile"
    fi
    mv "$tmpfile" "$file"
    echo "Added SPDX to $file"
  done
done
