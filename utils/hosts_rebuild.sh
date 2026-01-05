#!/usr/bin/env bash
# shellcheck disable=SC2086
#
# This script is used to rebuild the system configuration for the current host.
#
# SC2086 is ignored because we purposefully pass some values as a set of arguments, so we want the splitting to happen

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source common functions
# shellcheck source=./common.sh
source "$SCRIPT_DIR/common.sh"

# Build switch arguments
switch_args=$(build_switch_args "$@")

os=$(uname -s)
if [[ $os == "Darwin" ]]; then
  ## Darwin bootstrapping
  if ! which git &>/dev/null; then
    green "====== Installing Command-line tools for Xcode ======"
    xcode-select --install
  fi

  green "====== REBUILDING & SWITCHING (DARWIN) ======"
  # Test if there's no darwin-rebuild, then use nix build and then run it
  if ! which darwin-rebuild &>/dev/null; then
    nix build --show-trace --accept-flake-config .#darwinConfigurations."$HOST".system
    sudo ./result/sw/bin/darwin-rebuild $switch_args
  else
    echo $switch_args
    sudo darwin-rebuild $switch_args
  fi
else
  if which nix-on-droid &>/dev/null; then
    green "====== REBUILDING & SWITCHING (DROID) ======"
    echo $switch_args
    nix-on-droid $switch_args
  else
    green "====== REBUILDING & SWITCHING (NIXOS) ======"
    echo $switch_args
    sudo nixos-rebuild $switch_args
  fi
fi

# shellcheck disable=SC2181
if [ $? -eq 0 ]; then
  post_rebuild_success "host"
fi
