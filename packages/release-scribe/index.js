function createReleaseScribeConfig(overrides = {}) {
  return {
    packageName: "@clinwise/release-scribe",
    registry: "https://npm.pkg.github.com",
    scope: "@clinwise",
    ...overrides,
  };
}

module.exports = {
  createReleaseScribeConfig,
};
