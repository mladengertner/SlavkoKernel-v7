#!/usr/bin/env bash
set -euo pipefail
SBOM_FILE="sbom.cdx.json"
OUT_FILE="NOTICE"

if [ ! -f "$SBOM_FILE" ]; then
  echo "SBOM file $SBOM_FILE not found" >&2
  exit 1
fi

echo "NOTICE" > "$OUT_FILE"
echo "Copyright 2025 Mladen Gertner" >> "$OUT_FILE"
echo "" >> "$OUT_FILE"
echo "This product includes software licensed under the Apache License, Version 2.0." >> "$OUT_FILE"
echo "" >> "$OUT_FILE"
echo "Third-party components (from SBOM):" >> "$OUT_FILE"

# extract unique package name and license pairs using jq
jq -r '.components[] | "- \(.name) (\(.licenses[]?.license.name // "UNKNOWN"))"' "$SBOM_FILE" | sort -u >> "$OUT_FILE" || true

echo "" >> "$OUT_FILE"
echo "No additional notices." >> "$OUT_FILE"
