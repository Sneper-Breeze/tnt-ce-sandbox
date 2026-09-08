# Tarantool CE Sandbox

Minimal public-repository simulation for testing CE-to-EE backports with
`Sneper-Breeze/tnt-backport` as the EE repository.

## Flow

An EE backport declares a required CE SHA. The EE dependency workflow either:

1. opens an EE PR that advances its `tarantool` submodule when the SHA is
   already in the matching CE release branch; or
2. opens a CE backport PR when the SHA is not in that branch.

## GitHub setup

1. Create a public GitHub repository named `Sneper-Breeze/tnt-ce-sandbox` and
   push `main`, `release/3.3`, and `release/3.2`.
2. In `tnt-backport`, add `CE_BACKPORT_TOKEN`: a fine-grained token with
   `Contents: Read and write` and `Pull requests: Read and write` access
   to this repository. It is used by the EE workflow to create CE backport
   branches and pull requests.

The workflow assumes `main` maps to EE `main`; each `release/<x.y>` branch maps
to the EE branch with the same name.
