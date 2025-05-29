{inputs, ...}: {
  imports = [inputs.OS-nixCfg-secrets.modules.hostSpec];

  hostSpec = {
    inherit (inputs.OS-nixCfg-secrets.user) username userFullName handle email;
  };
}
