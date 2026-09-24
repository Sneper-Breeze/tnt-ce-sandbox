#!/usr/bin/env bash
set -euo pipefail

root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
workflow="$root/.github/workflows/submodule_update.yml"

expect_contains() {
  grep -Fq -- "$2" "$1" || {
    printf 'FAIL: %s does not contain: %s\n' "$1" "$2" >&2
    exit 1
  }
}

expect_contains "$workflow" 'release/**'
expect_contains "$workflow" 'TarantoolBot/update-tarantool-${{ github.ref_name }}'
expect_contains "$workflow" 'tarantool/actions/update-submodule@master'
expect_contains "$workflow" 'EE_UPDATE_SUBMODULE_TOKEN'
expect_contains "$workflow" 'repository: Sneper-Breeze/tnt-backport'
expect_contains "$workflow" 'checkout_branch: ${{ github.ref_name }}'
expect_contains "$workflow" 'pr_against_branch: ${{ github.ref_name }}'

printf 'PASS: CE submodule-update workflow contract checks\n'
