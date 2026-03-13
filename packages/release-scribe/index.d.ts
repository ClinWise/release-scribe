export interface ReleaseScribeConfig {
  packageName: string;
  registry: string;
  scope: string;
}

export declare function createReleaseScribeConfig(
  overrides?: Partial<ReleaseScribeConfig>,
): ReleaseScribeConfig;
