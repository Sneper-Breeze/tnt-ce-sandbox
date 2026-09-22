# Tarantool CE Sandbox

Minimal public-repository simulation for testing CE-to-EE backports with
`Sneper-Breeze/tnt-backport` as the EE repository.

## Flow

An EE backport declares a required CE SHA. The EE dependency workflow either:

1. discovers the bot-owned EE PR that advances its `tarantool` submodule when
   the SHA is already in the matching CE release branch; or
2. opens a CE backport PR when the SHA is not in that branch.

## GitHub setup

1. Create a public GitHub repository named `Sneper-Breeze/tnt-ce-sandbox` and
   push `main`, `release/3.3`, and `release/3.2`.
2. In `tnt-backport`, add `CE_BACKPORT_TOKEN`: a fine-grained token with
   `Contents: Read and write` and `Pull requests: Read and write` access
   to this repository. It is used by the EE workflow to create CE backport
   branches and pull requests.
3. In this repository, add `EE_UPDATE_SUBMODULE_TOKEN`: a fine-grained token
   with `Contents: Read and write` and `Pull requests: Read and write` access
   to `Sneper-Breeze/tnt-backport`. `submodule_update.yml` uses it after pushes
   to `main` or `release/*` to create or update
   `TarantoolBot/update-tarantool-<target>` in EE.

The workflow assumes `main` maps to EE `main`; each `release/<x.y>` branch maps
to the EE branch with the same name.
