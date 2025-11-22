#!/usr/bin/env bash
# Common functions for rebuild scripts

# Colored output functions
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

# Build switch arguments
# Usage: build_switch_args [trace]
function build_switch_args() {
  local args="-v --impure"
  if [[ -n ${1-} && $1 == "trace" ]]; then
    args="$args --show-trace"
  fi
  args="$args --flake .#$(hostname) switch"
  echo "$args"
}

# Post-rebuild success handler
# Usage: post_rebuild_success <tag_prefix>
function post_rebuild_success() {
  local tag_prefix="${1:-buildable}"

  green "====== POST-REBUILD ======"
  green "Rebuilt successfully"

  # Check if there are any pending changes that would affect the build succeeding.
  if git diff --exit-code >/dev/null && git diff --staged --exit-code >/dev/null; then
    # Check if the current commit has a buildable tag
    if git tag --points-at HEAD | grep -q buildable; then
      yellow "Current commit is already tagged as buildable"
    else
      git tag "${tag_prefix}-buildable-$(date +%Y%m%d%H%M%S)" -m ''
      green "Tagged current commit as buildable"
    fi
  else
    yellow "WARN: There are pending changes that would affect the build succeeding. Commit them before tagging"
  fi
}
