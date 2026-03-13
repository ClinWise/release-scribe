#!/usr/bin/env bash

set -euo pipefail

CURRENT_VERSION="$(node -p "require('./package.json').version")"

CLIFF_CONTEXT="$(pnpm exec git-cliff --unreleased --bump --context)"

BUMPED_VERSION="$(
  printf '%s' "${CLIFF_CONTEXT}" | node -e '
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

PENDING_CHANGESET_COUNT="$(
  find .changeset -maxdepth 1 -name '*.md' ! -name 'README.md' | wc -l | tr -d ' '
)"

if [ "${BUMPED_VERSION}" = "${CURRENT_VERSION}" ] && [ "${PENDING_CHANGESET_COUNT}" -gt 0 ]; then
  BUMPED_VERSION="$(
    node -e '
      const [major, minor, patch] = process.argv[1].split(".").map(Number);
      process.stdout.write(`${major}.${minor}.${patch + 1}`);
    ' "${CURRENT_VERSION}"
  )"
fi

if [ "${BUMPED_VERSION}" != "${CURRENT_VERSION}" ]; then
  pnpm version "${BUMPED_VERSION}" --no-git-tag-version
fi

if [ ! -s NEXT-CHANGELOG-ENTRY.md ]; then
  pnpm exec git-cliff --unreleased --output NEXT-CHANGELOG-ENTRY.md --strip header --bump
fi

pnpm changeset version
