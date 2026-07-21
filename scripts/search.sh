#!/usr/bin/env bash
# Search 200,000+ open-source icons via the Iconify API (no API key needed).
#
# Usage: search.sh "query" [limit] [prefix]
#   query   search terms, e.g. "shopping cart"
#   limit   max results (default 32)
#   prefix  restrict to an icon set, e.g. "lucide", "mdi", "tabler"
#
# Output: one icon id per line (prefix:name), ready for get.sh

set -euo pipefail

QUERY="${1:?Usage: search.sh \"query\" [limit] [prefix]}"
LIMIT="${2:-32}"
PREFIX="${3:-}"

command -v jq >/dev/null 2>&1 || { echo "error: jq is required (brew install jq / apt install jq)" >&2; exit 1; }

ENCODED=$(printf '%s' "$QUERY" | jq -sRr @uri)
# API enforces a minimum limit of 32, so request >= 32 and trim locally.
API_LIMIT=$(( LIMIT > 32 ? LIMIT : 32 ))
URL="https://api.iconify.design/search?query=${ENCODED}&limit=${API_LIMIT}"
[ -n "$PREFIX" ] && URL="${URL}&prefix=${PREFIX}"

curl -sf "$URL" | jq -r '.icons[]' | head -n "$LIMIT"
