#!/usr/bin/env bash
# Download an icon as SVG via the Iconify API (no API key needed).
#
# Usage: get.sh prefix:name [output.svg] [height] [color]
#   prefix:name  icon id from search.sh, e.g. "lucide:shopping-cart"
#   output.svg   output file (default: <name>.svg in cwd)
#   height       pixel height (default 24; width scales automatically)
#   color        CSS color, e.g. "#ff0000" (default currentColor)
#
# Prints the output path on success.

set -euo pipefail

ICON="${1:?Usage: get.sh prefix:name [output.svg] [height] [color]}"
case "$ICON" in *:*) ;; *) echo "error: icon must be prefix:name (e.g. lucide:home)" >&2; exit 1;; esac

PREFIX="${ICON%%:*}"
NAME="${ICON#*:}"
OUT="${2:-${NAME}.svg}"
HEIGHT="${3:-24}"
COLOR="${4:-currentColor}"
COLOR_ENC=$(printf '%s' "$COLOR" | sed 's/#/%23/g')

curl -sf "https://api.iconify.design/${PREFIX}/${NAME}.svg?height=${HEIGHT}&color=${COLOR_ENC}" -o "$OUT"

# The API returns 404 text for unknown icons; sanity-check the payload.
head -c 4 "$OUT" | grep -q '<svg' || { echo "error: icon '${ICON}' not found" >&2; rm -f "$OUT"; exit 1; }

echo "$OUT"
