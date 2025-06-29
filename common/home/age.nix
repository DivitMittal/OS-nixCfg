{
  inputs,
  config,
  ...
}: {
  imports = [inputs.ragenix.homeManagerModules.default];

  age.identityPaths = ["${config.home.homeDirectory}/.ssh/agenix/id_ed25519"];
  age.secretsDir = "${config.xdg.configHome}/agenix";

  age.secrets = {
    github.file = inputs.OS-nixCfg-secrets + "/secrets/github.age";
    weechatSec.file = inputs.OS-nixCfg-secrets + "/secrets/weechat/sec.conf";
    nixConf.file = inputs.OS-nixCfg-secrets + "/secrets/nix.conf";
  };
}
