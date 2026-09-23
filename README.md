# Tarantool CE Sandbox

Minimal public-repository simulation for CE-dependent EE backports consumed by
`Sneper-Breeze/tnt-backport`.

## Pipeline

EE declares a dependency with one complete PR-body line:

```text
Needs tarantool#<CE PR>
```

That replaces dependency labels and CE SHA fields. The EE resolver validates
that source PR is merged into CE `main`; for `release/3.3` or `release/3.4`, it
creates a CE release PR only when the source is absent from the mapped branch.

After a CE push to `main` or `release/**`,
`.github/workflows/submodule_update.yml` uses `EE_UPDATE_SUBMODULE_TOKEN` to
create or update the fixed EE branch
`TarantoolBot/update-tarantool-<branch>`. The EE resolver discovers that open
PR, records markdown `Backport:` and `Bump:` links plus a bot status comment,
and never creates an EE bump itself.

The EE verifier requires the EE `tarantool` gitlink to be the exact current tip
of the mapped CE branch: `main`, `release/3.3`, or `release/3.4`.

## GitHub Setup

1. Push CE `main`, `release/3.3`, and `release/3.4`.
2. In `tnt-backport`, configure `CE_BACKPORT_TOKEN` with Contents and Pull
   requests read/write access to this repository.
3. In this repository, configure `EE_UPDATE_SUBMODULE_TOKEN` with Contents and
   Pull requests read/write access to `Sneper-Breeze/tnt-backport`.
4. Allow Actions to create pull requests.

## Important State Detail

The resolver searches only open bot bump PRs. Once a bump merges, a later
resolver run can show `Bump: pending`; update the EE PR from the merged bump
instead of expecting another bump. `GITHUB_TOKEN` bot body edits and comments
do not trigger a new workflow, so a human EE body edit or synchronize event is
needed to retry discovery.

Use cloud-only Git mutations with `llm-origin`; do not reset, restore, or
force-push shared worktrees.
