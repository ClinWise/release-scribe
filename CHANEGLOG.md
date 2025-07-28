## [0.1.0] - 2025-07-28

### 🚀 Features

- *(api, web)* Update the .gitignore file to include the .turbo directory; add Node.js version and npm package manager information in package.json; refactor the workspace order; update scripts to use turbo for building, testing, and linting; add a turbo.json configuration file; add mock build and lint scripts in the package.json of the api and web applications.
- Changeset init
- *(api, web)* Add test file
- Add --bump to version script
- Re-add --bump to version script

### 🐛 Bug Fixes

- Fix the issue where the changeset command cannot be executed correctly in 'Create Release PR or Prepare for Publish'

### 🚜 Refactor

- Generate the file "NEXT-CHANGELOG-ENTRY.md" in the "release.yml" file
