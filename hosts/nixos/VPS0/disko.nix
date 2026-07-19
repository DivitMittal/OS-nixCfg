_: {
  # VPS0 Oracle Cloud A1 Flex: single OCI block volume, UEFI boot.
  disko.devices = {
    disk.main = {
      device = "/dev/disk/by-id/scsi-36075f9bc9c73417586c6fd09a98be681";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            size = "512M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = ["umask=0077"];
            };
          };
          swap = {
            size = "4G";
            content = {
              type = "swap";
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
