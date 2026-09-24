# CE Sandbox

This repository simulates public `tarantool`; `Sneper-Breeze/tnt-backport` is
its EE consumer.

## Current Contract

- Supported branches are `main`, `release/3.3`, and `release/3.4`; each maps
  to the identically named EE branch.
- An EE dependency is declared only as `Needs tarantool#<CE-PR>` in the EE PR
  body. Do not use `requires-ce-backport`, `CE-Fix-SHA`, or user-provided SHAs.
- The EE resolver validates the merged CE source PR on `main` and creates CE
  release PRs from `ee-dependency/release/<x.y>/pr-<EE-PR>` when needed.
- CE `.github/workflows/submodule_update.yml` owns the EE bump PR on
  `TarantoolBot/update-tarantool-<branch>`. It uses
  `EE_UPDATE_SUBMODULE_TOKEN`; EE only discovers the open bump PR.
- The EE verifier requires an EE `tarantool` gitlink to equal the exact current
  tip of its mapped CE branch.

## PR State

- Resolver writes markdown `Backport:` and `Bump:` links in its managed EE PR
  body section and keeps a bot status comment.
- The resolver searches only open bot bump PRs. After a bump merges, a later
  report may show `Bump: pending`; update the EE PR from the merged bump rather
  than creating another.
- `GITHUB_TOKEN`-created PR events, comments, and body edits do not trigger
  follow-up workflows. A human body edit or EE PR synchronize event requests
  another resolver pass.

## Safety

- Keep `submodule_update.yml` limited to `main` and `release/**` pushes and the
  fixed bot branch convention.
- Do not use reset, restore, force-push, or force-reset.
- Perform state-changing Git operations only on the cloud host with the HTTPS
  `llm-origin` remote. Preserve unrelated primary-worktree changes.
