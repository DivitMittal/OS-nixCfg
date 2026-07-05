# External volumes mounted via CLI only (noauto + nobrowse).
# Identified by UUID so device path changes don't break entries.
# Mount with:  sudo mount /mnt/p128  or  sudo mount /mnt/s32
{lib, ...}: {
  # /etc/fstab must be a real file, not a nix-darwin environment.etc symlink:
  # macOS needs it before /nix is mounted, so pointing it into /nix is circular.
  #
  # Synthetic entries take effect after reboot. /nix stays a synthetic mount
  # point; /mnt points at the writable data volume so child mount points exist.
  system.activationScripts.preActivation.text = lib.mkBefore ''
    synthetic_conf=/etc/synthetic.conf
    tmp="$(mktemp)"
    fstab=/private/etc/fstab

    touch "$synthetic_conf"
    chmod 644 "$synthetic_conf"

    grep -Fvx \
      -e "nix" \
      -e "mnt" \
      -e "mnt	System/Volumes/Data/mnt" \
      "$synthetic_conf" > "$tmp" || true

    {
      cat "$tmp"
      printf '%s\n' "nix"
      printf '%s\t%s\n' "mnt" "System/Volumes/Data/mnt"
    } > "$synthetic_conf"
    rm -f "$tmp"

    rm -f "$fstab"
    cat > "$fstab" <<'EOF'
    UUID=901C5E01-7A35-491A-987B-948FBFB7CB79 /nix apfs rw,noauto,nobrowse,suid,owners
    UUID=2BB1DF38-9B3A-39A2-BB79-602B5C066B5E /mnt/p128 exfat rw,noauto,nobrowse
    UUID=C8A7751B-FC10-3F4D-AC05-80AEFB8BC352 /mnt/s32  exfat rw,noauto,nobrowse
    EOF
    chmod 644 "$fstab"
    chown root:wheel "$fstab"

    mkdir -p /System/Volumes/Data/mnt/p128 /System/Volumes/Data/mnt/s32
  '';
}
