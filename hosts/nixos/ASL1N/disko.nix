_: {
  # IMPORTANT: Apple Silicon requires the Asahi Linux installer to be run on macOS FIRST.
  # https://github.com/AsahiLinux/asahi-installer  (curl https://alx.sh | sh)
  #
  # The Asahi installer allocates free space and creates two partitions:
  #   nvme0n1pN   EFI partition (~500 MB, FAT32) — U-Boot lives here, do not reformat
  #   nvme0n1pM   Linux data partition — all your allocated space, formatted below
  #
  # After booting the installer ISO, run `lsblk -f /dev/nvme0n1` to find the Linux
  # data partition, then update disk.nixos.device below before running `disko`.
  disko.devices = {
    disk.nixos = {
      # Linux data partition allocated by Asahi — adjust partition path as needed
      device = "/dev/nvme0n1p6";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          swap = {
            size = "8G";
            content = {
              type = "swap";
              randomEncryption = true;
            };
          };
          root = {
            size = "100%";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
            };
          };
        };
      };
    };
  };
}
