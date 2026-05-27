#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

if ! command -v typst >/dev/null 2>&1; then
  echo "Error: typst is not installed or not on PATH." >&2
  exit 127
fi

typst compile main.typ main.pdf
