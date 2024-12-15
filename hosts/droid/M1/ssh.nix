{ config, pkgs, ... }:

let
  sshdTmpDirectory = "${config.user.home}/.sshd-tmp";
  sshdDirectory = "${config.user.home}/.sshd";
  pathToPubKey = "${sshdDirectory}/ssh_host_rsa_key.pub";
  port = 8022;
in
{
  environment.packages = builtins.attrValues {
    sshd = (pkgs.writeScriptBin "sshd-start" ''
      #!${pkgs.runtimeShell}

      echo "Starting sshd in non-daemonized way on port ${toString port}"
      ${pkgs.openssh}/bin/sshd -f "${sshdDirectory}/sshd_config" -D
    '');
  };

  build.activation.sshd = ''
    if [[ ! -d "${sshdDirectory}" ]]; then
      $DRY_RUN_CMD rm $VERBOSE_ARG -rf "${sshdTmpDirectory}"
      $DRY_RUN_CMD mkdir $VERBOSE_ARG -p "${sshdTmpDirectory}"

      $VERBOSE_ECHO "Generating host keys..."
      $DRY_RUN_CMD ${pkgs.openssh}/bin/ssh-keygen -t rsa -b 4096 -f "${sshdTmpDirectory}/ssh_host_rsa_key" -N ""

      $VERBOSE_ECHO "Writing sshd_config..."
      $DRY_RUN_CMD echo -e "HostKey ${sshdDirectory}/ssh_host_rsa_key\nPort ${toString port}\n" > "${sshdTmpDirectory}/sshd_config"

      $DRY_RUN_CMD mv $VERBOSE_ARG "${sshdTmpDirectory}" "${sshdDirectory}"
    fi

    $DRY_RUN_CMD mkdir $VERBOSE_ARG -p "${config.user.home}/.ssh"
    $DRY_RUN_CMD cat ${pathToPubKey} > "${config.user.home}/.ssh/authorized_keys"
  '';
}
