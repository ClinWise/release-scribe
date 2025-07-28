#!/bin/bash

git cliff --unreleased --bump --context | jq -r ".[0].version" | xargs -I {} npm version {} --git-tag-version=false

if [ ! -s NEXT-CHANGELOG-ENTRY.md ]; then  
  git cliff --unreleased --output NEXT-CHANGELOG-ENTRY.md --strip header --bump
fi

npx changeset version