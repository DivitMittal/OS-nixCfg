#!/usr/bin/env bash
# shellcheck disable=SC2086
#
# This script is used to rebuild the system configuration for the current host.
#
# SC2086 is ignored because we purposefully pass some values as a set of arguments, so we want the splitting to happen

function red() {
  echo -e "\x1B[31m[!] $1 \x1B[0m"
  if [ -n "${2-}" ]; then
    echo -e "\x1B[31m[!] $($2) \x1B[0m"
  fi
}
function green() {
  echo -e "\x1B[32m[+] $1 \x1B[0m"
  if [ -n "${2-}" ]; then
    echo -e "\x1B[32m[+] $($2) \x1B[0m"
  fi
}
function yellow() {
  echo -e "\x1B[33m[*] $1 \x1B[0m"
  if [ -n "${2-}" ]; then
    echo -e "\x1B[33m[*] $($2) \x1B[0m"
  fi
}

switch_args="-v --impure"
if [[ -n $1 && $1 == "trace" ]]; then
  switch_args="$switch_args --show-trace"
fi

switch_args="$switch_args --flake .#$(hostname) switch"

green "====== REBUILDING & SWITCHING (HOME) ======"

if ! which home-manager &>/dev/null; then
  red "Home Manager is not installed"
  yellow "Run nix-shell"
else
  home-manager $switch_args
fi

# shellcheck disable=SC2181
if [ $? -eq 0 ]; then
  green "====== POST-REBUILD ======"
  green "Rebuilt successfully"

  # Check if there are any pending changes that would affect the build succeeding.
  if git diff --exit-code >/dev/null && git diff --staged --exit-code >/dev/null; then
    # Check if the current commit has a buildable tag
    if git tag --points-at HEAD | grep -q buildable; then
      yellow "Current commit is already tagged as buildable"
    else
      git tag home-buildable-"$(date +%Y%m%d%H%M%S)" -m ''
      green "Tagged current commit as buildable"
    fi
  else
    yellow "WARN: There are pending changes that would affect the build succeeding. Commit them before tagging"
  fi
fi
