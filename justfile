default:
  @just --list

sw:
  # NOTE: Add --option eval-cache false if you end up caching a failure you can't get around
  ./scripts/hosts_rebuild.sh

swt:
  ./scripts/hosts_rebuild.sh trace

update:
  nix flake update

hms:
  ./scripts/home_rebuild.sh

hmst:
  ./scripts/home_rebuild.sh trace