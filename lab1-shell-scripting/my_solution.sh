#!/usr/bin/env bash
set -euo pipefail

usage() {
  echo "Usage: $0 <directory> <basename-without-extension>" >&2
  exit 2
}

[[ $# -eq 2 ]] || usage
root_dir=$1
base_name=$2

if [[ ! -d "$root_dir" ]]; then
  echo "Error: '$root_dir' is not a directory or does not exist." >&2
  exit 1
fi
if [[ -z "$base_name" ]]; then
  echo "Error: basename must be non-empty." >&2
  exit 1
fi

LC_ALL=C find "$root_dir" -mindepth 2 -type f -name "${base_name}.*" \
  -exec dirname {} \; \
| xargs -n1 basename \
| LC_ALL=C sort -u
