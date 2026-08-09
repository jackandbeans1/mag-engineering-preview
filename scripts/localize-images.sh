#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────
# localize-images.sh
#
# The page currently hot-links its job photos from the old GoDaddy
# staging site. That's fine for a preview, but the moment that site is
# taken down every photo on this one breaks.
#
# This downloads them into assets/img/ and repoints index.html at the
# local copies. Run it once, from the repo root:
#
#     bash scripts/localize-images.sh
#
# Then commit assets/img/ and the updated index.html.
# ─────────────────────────────────────────────────────────────────────
set -euo pipefail

BASE="https://645739.us26.myftpupload.com/wp-content/uploads/2024/02"
OUT="assets/img"

FILES=(
  "slide-1-1.jpg"
  "slide-2.jpg"
  "slide-4.jpg"
  "EQUIOPMENT-2-9d259fa-1.png"
  "ENGINEERING-1-9e0a542-1.jpg"
  "ENGINEERING-3-e918975-1.jpg"
  "ENGINEERING-15-12de68e-1.jpg"
  "WET-1-848fb1f-1.jpg"
  "WET-5-988fafd-1.jpg"
  "WET-8-e3ce1ab-1.jpg"
  "DRY-4-881adde-1.jpg"
)

mkdir -p "$OUT"

echo "Downloading ${#FILES[@]} images to $OUT/ ..."
for f in "${FILES[@]}"; do
  if curl -fsSL "$BASE/$f" -o "$OUT/$f"; then
    printf '  ok    %s\n' "$f"
  else
    printf '  FAIL  %s  (grab this one manually)\n' "$f"
  fi
done

echo "Repointing index.html at local copies ..."
# macOS and GNU sed take different -i arguments
if sed --version >/dev/null 2>&1; then
  sed -i "s|$BASE/|$OUT/|g" index.html
else
  sed -i '' "s|$BASE/|$OUT/|g" index.html
fi

REMAINING=$(grep -c "myftpupload" index.html || true)
echo "Done. Remaining external image references: $REMAINING"
echo "Review the page locally, then commit assets/img/ and index.html."
