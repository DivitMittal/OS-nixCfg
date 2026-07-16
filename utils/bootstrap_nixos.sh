#!/usr/bin/env bash
# Remote first-install bootstrap for NixOS hosts.
#
# This is intentionally separate from bootstrap.sh: it runs nixos-anywhere and
# can destroy target disks. Use deploy-rs for steady-state changes after install.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=./common.sh
source "$SCRIPT_DIR/common.sh"

usage() {
  cat <<'EOF'
Usage:
  bootstrap-nixos <host> --target <ssh-target> --check [options]
  bootstrap-nixos <host> --target <ssh-target> --yes-destroy-disk [options]

Arguments:
  <host>                  Host attr under .#nixosConfigurations.<host>.

Options:
  --target <ssh-target>   SSH target for rescue/current Linux, e.g. root@203.0.113.10.
  --check                 Run local/remote preflight checks only; do not install.
  --yes-destroy-disk      Confirm that nixos-anywhere may partition/format disks.
  --disk <path>           Block device to check before install; default: /dev/sda.
  --agenix-identity <path>
                          Copy this local private key to /var/lib/agenix/id_ed25519.
  --no-agenix             Do not seed an agenix identity with --extra-files.
  --build-on <mode>       nixos-anywhere build mode: remote, local, or auto. Default: remote.
  --port <port>           SSH port.
  --ssh-identity <path>   SSH identity for reaching the rescue/current system.
  --ssh-option <option>   Extra SSH option for both ssh and nixos-anywhere.
  -h, --help              Show this help.

Environment:
  AGENIX_IDENTITY_PATH    Default for --agenix-identity when set.
EOF
}

host=""
target=""
target_disk="/dev/sda"
check_only=false
destroy_confirmed=false
seed_agenix=true
agenix_identity="${AGENIX_IDENTITY_PATH:-}"
build_on="remote"
port=""
ssh_identity=""
ssh_options=()

require_value() {
  local option="$1"
  local value="${2:-}"

  if [[ -z $value ]]; then
    red "Missing value for $option."
    usage
    exit 1
  fi
}

while [[ $# -gt 0 ]]; do
  case "$1" in
  --target)
    require_value "$1" "${2:-}"
    target="$2"
    shift
    ;;
  --check)
    check_only=true
    ;;
  --yes-destroy-disk)
    destroy_confirmed=true
    ;;
  --disk)
    require_value "$1" "${2:-}"
    target_disk="$2"
    shift
    ;;
  --agenix-identity)
    require_value "$1" "${2:-}"
    agenix_identity="$2"
    seed_agenix=true
    shift
    ;;
  --no-agenix)
    seed_agenix=false
    ;;
  --build-on)
    require_value "$1" "${2:-}"
    build_on="$2"
    shift
    ;;
  --port)
    require_value "$1" "${2:-}"
    port="$2"
    shift
    ;;
  --ssh-identity)
    require_value "$1" "${2:-}"
    ssh_identity="$2"
    shift
    ;;
  --ssh-option)
    require_value "$1" "${2:-}"
    ssh_options+=("$2")
    shift
    ;;
  -h | --help)
    usage
    exit 0
    ;;
  --*)
    red "Unknown option: $1"
    usage
    exit 1
    ;;
  *)
    if [[ -n $host ]]; then
      red "Host specified more than once."
      usage
      exit 1
    fi
    host="$1"
    ;;
  esac
  shift
done

if [[ -z $host ]]; then
  red "Choose a host from .#nixosConfigurations."
  usage
  exit 1
fi

if [[ -z $target ]]; then
  red "Missing --target <ssh-target>."
  yellow "Example: bootstrap-nixos $host --target root@203.0.113.10 --check"
  exit 1
fi

if [[ $check_only == true && $destroy_confirmed == true ]]; then
  red "Use either --check or --yes-destroy-disk, not both."
  exit 1
fi

if [[ $check_only == false && $destroy_confirmed == false ]]; then
  red "Refusing to run destructive install without --yes-destroy-disk."
  yellow "Run with --check first to validate the target without changing it."
  exit 1
fi

case "$build_on" in
remote | local | auto)
  ;;
*)
  red "Invalid --build-on value: $build_on"
  yellow "Use one of: remote, local, auto."
  exit 1
  ;;
esac

if [[ $seed_agenix == true && -z $agenix_identity ]]; then
  agenix_identity="$HOME/.ssh/agenix/id_ed25519"
fi

ssh_args=(
  -o BatchMode=yes
  -o ConnectTimeout=10
  -o StrictHostKeyChecking=accept-new
)
if [[ -n $port ]]; then
  ssh_args+=(-p "$port")
fi
if [[ -n $ssh_identity ]]; then
  ssh_args+=(-i "$ssh_identity")
fi
for option in "${ssh_options[@]}"; do
  ssh_args+=(-o "$option")
done

nixos_anywhere_args=(--flake ".#$host" --build-on "$build_on")
if [[ -n $port ]]; then
  nixos_anywhere_args+=(-p "$port")
fi
if [[ -n $ssh_identity ]]; then
  nixos_anywhere_args+=(-i "$ssh_identity")
fi
for option in "${ssh_options[@]}"; do
  nixos_anywhere_args+=(--ssh-option "$option")
done

run_preflight_checks() {
  green "====== NIXOS REMOTE BOOTSTRAP PREFLIGHT ($host) ======"

  if [[ ! -f "$PWD/flake.nix" ]]; then
    red "No flake.nix in current directory ($PWD)."
    yellow "cd into the OS-nixCfg repo root before running bootstrap-nixos."
    exit 1
  fi
  green "Repository root: $PWD"

  if ! command -v nix >/dev/null 2>&1; then
    red "nix is not available on PATH."
    exit 1
  fi
  green "Nix: $(nix --version | head -n1)"

  if ! command -v nixos-anywhere >/dev/null 2>&1; then
    red "nixos-anywhere is not available on PATH."
    yellow "Enter the project devshell first: nix develop"
    exit 1
  fi
  green "nixos-anywhere: $(nixos-anywhere --version 2>/dev/null || command -v nixos-anywhere)"

  if [[ $seed_agenix == true ]]; then
    if [[ ! -f $agenix_identity ]]; then
      red "Missing agenix identity: $agenix_identity"
      yellow "Pass --agenix-identity <path>, set AGENIX_IDENTITY_PATH, or use --no-agenix."
      exit 1
    fi
    green "agenix identity exists: $agenix_identity"
  else
    yellow "Skipping agenix identity seeding."
  fi

  green "Evaluating .#nixosConfigurations.$host.config.system.build.toplevel"
  nix eval --raw --show-trace --accept-flake-config ".#nixosConfigurations.$host.config.system.build.toplevel.drvPath" >/dev/null

  green "Checking SSH connectivity: $target"
  ssh "${ssh_args[@]}" "$target" true

  green "Checking target disk exists: $target_disk"
  ssh "${ssh_args[@]}" "$target" "test -b '$target_disk'"
}

run_install() {
  local extra_files=""

  if [[ $seed_agenix == true ]]; then
    extra_files="$(mktemp -d)"
    trap 'rm -rf "$extra_files"' EXIT
    install -D -m 0600 "$agenix_identity" "$extra_files/var/lib/agenix/id_ed25519"
    nixos_anywhere_args+=(--extra-files "$extra_files")
  fi

  yellow "About to run nixos-anywhere for $host against $target."
  yellow "This may partition/format disks according to the selected NixOS configuration."
  yellow "Preflight checked target disk: $target_disk."

  nixos-anywhere \
    "${nixos_anywhere_args[@]}" \
    "$target"
}

run_preflight_checks

if [[ $check_only == true ]]; then
  green "Preflight passed; no destructive action was taken."
  exit 0
fi

run_install
