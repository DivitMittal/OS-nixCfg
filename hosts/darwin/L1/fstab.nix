# External volumes mounted via CLI only (noauto + nobrowse).
# Identified by UUID so device path changes don't break entries.
# Mount with:  sudo mount /mnt/p128  or  sudo mount /mnt/s32
{
  environment.etc."fstab".text = ''
    # Existing Nix store volume (managed by Nix installer)
    UUID=901C5E01-7A35-491A-987B-948FBFB7CB79 /nix apfs rw,noauto,nobrowse,suid,owners

    # External volumes — CLI-only, no auto-mount
    UUID=2BB1DF38-9B3A-39A2-BB79-602B5C066B5E /mnt/p128 exfat rw,noauto,nobrowse
    UUID=C8A7751B-FC10-3F4D-AC05-80AEFB8BC352 /mnt/s32  exfat rw,noauto,nobrowse
  '';

  system.activationScripts.preActivation = {
    text = ''
      # Ensure mount points exist
      mkdir -p /mnt/p128 /mnt/s32
    '';
  };
}
