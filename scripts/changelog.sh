#!/usr/bin/env bash
set -euo pipefail

# Find the tag pointing to HEAD, if any
current_tag=$(git tag --points-at HEAD --sort=-version:refname | head -n 1)

# Find the previous tag
if [ -n "$current_tag" ]; then
    previous_tag=$(git tag --sort=-version:refname | grep -A 1 "^${current_tag}$" | tail -n 1)
else
    previous_tag=$(git tag --sort=-version:refname | head -n 1)
fi

if [ -z "$previous_tag" ]; then
    echo "No previous tag found; showing full history." >&2
    range="HEAD"
else
    range="${previous_tag}..HEAD"
fi

git log --pretty=format:"%h %s" "$range"
