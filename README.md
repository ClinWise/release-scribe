# Release-Scribe

This GitHub Action provides a robust, automated release workflow by seamlessly integrating
[changesets/action](https://github.com/changesets/action) with [git-cliff](https://github.com/orhun/git-cliff).


While changesets is excellent for versioning in monorepos, its default changelog generation is limited. 

This action enhances the process by using git-cliff to generate beautiful, structured changelogs from your Conventional Commits.

Its key feature is a unique two-step changelog process:

1. Preview: When changesets creates a versioning pull request, this action generates a pending changelog and includes it in the PR for team review.

2. Publish: Once the PR is merged, the action automatically updates the root CHANGELOG.md, creates a new Git tag, and publishes a polished GitHub Release.

Key Features:
- 🔄 Automated Versioning: Leverages changesets to manage package versions.
- ✨ Rich Changelogs: Uses git-cliff to generate detailed changelogs from Conventional Commits.
- 👀 Reviewable Release Notes: The "preview" changelog in the PR ensures transparency and quality control before a release goes live.
- 🚀 Zero-Config Goal: Designed to work out-of-the-box for most standard setups.
- 🌳 Monorepo-Ready: Inherits changesets' excellent support for monorepos.

## Bonus: Prisma Support

This workflow includes caching and generation steps for Prisma clients, demonstrating how to integrate database-related tasks into your CI/CD pipeline.

While not entirely generic, if you use Prisma, this might provide some valuable insights.

## The Workflow

```mermaid
graph TD
    start[Start] --> trigger_events{Trigger Events};

    trigger_events -- "push to main branch" --> job_conditions;
    trigger_events -- "CI workflow completed" --> job_conditions;

    job_conditions{"CI workflow successful?"} -- True --> checkout_repo["Checkout Repository"];
    job_conditions -- False --> end_node[End];

    checkout_repo --> setup_node["Setup Node.JS"];
    setup_node --> install_deps["Install Dependencies"];
    install_deps --> install_git_cliff["Install git-cliff"];
    install_git_cliff --> config_git["Configure Git"];
    config_git --> run_changesets["changesets/action: Create Version PR or Prepare Release"];

    run_changesets -- "hasChangesets == 'true'" --> changesets_pr_done["Version PR Created"];
    run_changesets -- "hasChangesets == 'false'" --> publish_step_start["Enter Publish Flow"];

    publish_step_start --> check_changelog_file{"NEXT-CHANGELOG-ENTRY.md exists and is not empty?"};

    check_changelog_file -- Yes --> get_bumped_ver["Get BUMPED_VERSION"];
    check_changelog_file -- No --> set_released_false_skip["Set released=false (Skip Release)"];

    get_bumped_ver --> check_bumped_ver{"BUMPED_VERSION is empty?"};

    check_bumped_ver -- Yes --> handle_no_bump["Clean NEXT-CHANGELOG-ENTRY.md"];
    check_bumped_ver -- No --> prepare_release_notes["Prepare RELEASE_NOTES.md"];

    prepare_release_notes --> update_main_changelog["Update Main CHANGELOG.md"];
    update_main_changelog --> clean_next_changelog["Clean NEXT-CHANGELOG-ENTRY.md"];
    clean_next_changelog --> commit_release_changes["Commit Release Changes"];
    commit_release_changes --> create_push_tag["Create and Push Tag"];
    create_push_tag --> set_released_true["Set released=true"];

    set_released_true --> create_github_release_cond;
    handle_no_bump --> create_github_release_cond;
    set_released_false_skip --> create_github_release_cond;

    create_github_release_cond{"released == 'true'?"};
    create_github_release_cond -- Yes --> create_gh_release["Create GitHub Release"];
    create_github_release_cond -- No --> end_node;

    create_gh_release --> end_node;
    changesets_pr_done --> end_node;
```