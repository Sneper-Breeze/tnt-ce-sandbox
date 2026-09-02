# Tarantool CE Sandbox

Minimal public-repository simulation for testing CE-to-EE backports with
`Sneper-Breeze/tnt-backport` as the EE repository.

## Flow

1. Merge a labeled CE backport into `release/<x.y>`.
2. `sync-ee-submodule.yml` opens an EE PR that moves the `tarantool` submodule
   to that exact CE commit.
3. Merge the pointer bump before merging an EE backport that declares the CE
   fix with `CE-Fix-SHA: <sha>`.

## GitHub setup

1. Create a public GitHub repository named `Sneper-Breeze/tnt-ce-sandbox` and
   push `main`, `release/3.3`, and `release/3.2`.
2. In this repository, add `EE_UPDATE_SUBMODULE_TOKEN`: a fine-grained token
   with `Contents: Read and write` and `Pull requests: Read and write` access
   to private `Sneper-Breeze/tnt-backport`.
3. In `tnt-backport`, configure the `tarantool` submodule URL as
   `https://github.com/Sneper-Breeze/tnt-ce-sandbox.git`.

The workflow assumes `main` maps to EE `main`; each `release/<x.y>` branch maps
to the EE branch with the same name.
