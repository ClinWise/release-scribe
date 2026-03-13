# Changelog

All notable changes to this project will be documented in this file.

## [unreleased]

### Features

- Migrate release automation workflow to pnpm



### Bug Fixes

- Fix duplicate version number headers in release notes



### Refactor

- Try to optimize the speed of CI workflow



### Documentation

- Update


## [0.2.2] - 2025-07-29

### Bug Fixes

- Attempt to fix the issue where the modification to NEXT-CHANGELOG-ENTRY.md in the version package pr is invalid

- Avoid triggering changes within the version package PR itself :)



### Documentation

- Update README


## [0.2.1] - 2025-07-28

### Bug Fixes

- Fix the issue where the commited log in NEXT-CHANGELOG-ENTRY is empty



### Refactor

- Modify the version update logic of package.json in the project root directory in the changeset-version script



### Documentation

- Update README


## [0.2.0] - 2025-07-28

### Features

- Use changeset-version.sh to update package.json version



### Testing

- Try to use version script



### Chore

- Rename version script to changeset:version


## [0.1.1] - 2025-07-28

### Testing

- Test


## [0.1.0] - 2025-07-28

### Features

- *(api, web)* Update the .gitignore file to include the .turbo directory; add Node.js version and npm package manager information in package.json; refactor the workspace order; update scripts to use turbo for building, testing, and linting; add a turbo.json configuration file; add mock build and lint scripts in the package.json of the api and web applications.

- Changeset init

- *(api, web)* Add test file

- Add --bump to version script

- Re-add --bump to version script



### Bug Fixes

- Fix the issue where the changeset command cannot be executed correctly in 'Create Release PR or Prepare for Publish'



### Refactor

- Generate the file "NEXT-CHANGELOG-ENTRY.md" in the "release.yml" file



### Chore

- Add CHANGELOG.md

- Typo



