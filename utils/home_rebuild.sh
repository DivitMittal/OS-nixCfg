#!/usr/bin/env bash
# shellcheck disable=SC2086
#
# This script is used to rebuild the home-manager configuration for the current host.
#
# SC2086 is ignored because we purposefully pass some values as a set of arguments, so we want the splitting to happen

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source common functions
# shellcheck source=./common.sh
source "$SCRIPT_DIR/common.sh"

# Build switch arguments
switch_args=$(build_switch_args "$@")

green "====== REBUILDING & SWITCHING (HOME) ======"

if ! which home-manager &>/dev/null; then
  red "Home Manager is not installed"
  yellow "Run nix-shell"
else
  echo $switch_args
  home-manager $switch_args
fi

# shellcheck disable=SC2181
if [ $? -eq 0 ]; then
  post_rebuild_success "home"
fi
