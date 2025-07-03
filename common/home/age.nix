{
  inputs,
  config,
  ...
}: {
  imports = [inputs.ragenix.homeManagerModules.default];

  age.identityPaths = ["${config.home.homeDirectory}/.ssh/agenix/id_ed25519"];
  age.secretsDir = "${config.xdg.configHome}/agenix";

  age.secrets = let
    secretsPath = inputs.OS-nixCfg-secrets + "/secrets";
  in {
    "api/github.txt".file = secretsPath + "/api/github.age";
    "weechat/sec.conf".file = secretsPath + "/weechat/sec.conf.age";
    "nix.conf".file = secretsPath + "/nix.conf.age";
    "id_passage".file = secretsPath + "/passage.age";
  };
}
