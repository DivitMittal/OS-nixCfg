# External volumes mounted via CLI only (noauto + nobrowse).
# Identified by UUID so device path changes don't break entries.
# Mount with:  sudo mount /mnt/p128  or  sudo mount /mnt/s32
{lib, ...}: {
  environment.etc."fstab".text = ''
    # Existing Nix store volume (managed by Nix installer)
    UUID=901C5E01-7A35-491A-987B-948FBFB7CB79 /nix apfs rw,noauto,nobrowse,suid,owners

    # External volumes — CLI-only, no auto-mount
    UUID=2BB1DF38-9B3A-39A2-BB79-602B5C066B5E /mnt/p128 exfat rw,noauto,nobrowse
    UUID=C8A7751B-FC10-3F4D-AC05-80AEFB8BC352 /mnt/s32  exfat rw,noauto,nobrowse
  '';

  # Synthetic firmlinks so /nix, /run, and /mnt resolve on the writable data
  # volume. Takes effect after the next reboot; first-time setup must reboot
  # once for the firmlinks to appear.
  system.activationScripts.preActivation.text = lib.mkBefore ''
    synthetic_conf=/etc/synthetic.conf
    tmp="$(mktemp)"

    touch "$synthetic_conf"
    chmod 644 "$synthetic_conf"

    grep -Fvx \
      -e "nix" \
      -e "mnt" \
      "$synthetic_conf" > "$tmp" || true

    {
      cat "$tmp"
      printf '%s\n' "nix"
      printf '%s\n' "mnt"
    } > "$synthetic_conf"
    rm -f "$tmp"

    # Ensure mount-point directories exist on the data volume.
    mkdir -p /System/Volumes/Data/mnt/p128 /System/Volumes/Data/mnt/s32
  '';
}
