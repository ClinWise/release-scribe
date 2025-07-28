#!/bin/bash

git cliff --unreleased --bump --context | jq -r ".[0].version" | xargs npm version
git cliff --unreleased --output NEXT-CHANGELOG-ENTRY.md --strip header --bump && npx changeset version