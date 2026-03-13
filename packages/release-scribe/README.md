# @clinwise/release-scribe

This package exists to prove the end-to-end Release Scribe workflow.

It is intentionally small. The package gives the repository one real publish target so the
following path can be tested:

- changeset version PR creation
- package publish to GitHub Packages
- root changelog generation with git-cliff
- GitHub Release creation

## Usage

```js
const { createReleaseScribeConfig } = require("@clinwise/release-scribe");

const config = createReleaseScribeConfig();
```
