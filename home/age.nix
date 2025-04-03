{
  inputs,
  config,
  ...
}: {
  age.identityPaths = ["${config.home.homeDirectory}/.ssh/agenix/id_ed25519"];
  age.secretsDir = "${config.xdg.configHome}/agenix";

  age.secrets = {
    github.file = inputs.OS-nixCfg-secrets + /secrets/github.age;
  };
}
