# CE Sandbox

This minimal repository simulates public `tarantool`. Its private EE consumer
is the sibling `../backport` repository, published as
`Sneper-Breeze/tnt-backport`.

## Branches and Role

- Supported branches are `main`, `release/3.3`, and `release/3.2`.
- CE `backport.yml` creates ordinary CE backport PRs for `backport/<x.y>`.
- CE `submodule_update.yml` owns automatic EE gitlink bumps on
  `TarantoolBot/update-tarantool-<target>`. EE's resolver only discovers them.
- The EE resolver may create CE branches named
  `ee-dependency/release/<x.y>/pr-<EE-PR>` and target CE `release/<x.y>`.

## Test Contract

Create a CE fix on `main` only. An EE feature PR to `main`, labeled
`backport/<x.y>` and `requires-ce-backport`, declares that fix via
`CE-Fix-SHA: <sha>`. After the EE backport PR is created for `release/<x.y>`,
the EE resolver creates the CE backport PR if that SHA is not on CE release.

Use individual CE fix commits whenever possible. A CE cherry-pick has a new
SHA; `git cherry-pick -x` adds a trailer that proves its original source.

## Safety

- Keep `submodule_update.yml` limited to CE `main` and `release/*` pushes and
  its fixed bot-owned EE branch convention.
- Keep CE release branches independent from `main`; a CE fix must not become an
  ancestor of a release branch before the dependency test.
- Use `git commit -m '...'` only. Never rely on Vim or another interactive
  editor during automated Git operations.
