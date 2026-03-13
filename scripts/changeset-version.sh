#!/usr/bin/env bash

set -euo pipefail

BUMPED_VERSION="$(
  pnpm exec git-cliff --unreleased --bump --context | node -e '
    let data = "";
    process.stdin.setEncoding("utf8");
    process.stdin.on("data", (chunk) => {
      data += chunk;
    });
    process.stdin.on("end", () => {
      const releases = JSON.parse(data);
      process.stdout.write(releases?.[0]?.version ?? "");
    });
  '
)"

if [ -z "${BUMPED_VERSION}" ]; then
  echo "Unable to determine the next release version from git-cliff." >&2
  exit 1
fi

pnpm version "${BUMPED_VERSION}" --no-git-tag-version

if [ ! -s NEXT-CHANGELOG-ENTRY.md ]; then
  pnpm exec git-cliff --unreleased --output NEXT-CHANGELOG-ENTRY.md --strip header --bump
fi

pnpm changeset version
