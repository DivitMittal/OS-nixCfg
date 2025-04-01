{ inputs, config, ... }:

let
  secrets = inputs.OS-nixCfg-secrets.outPath + /secrets;
in
{
  age.identityPaths = [ "${config.home.homeDirectory}/.ssh/agenix/id_ed25519" ];

  age.secrets = {
    groq.file = secrets + /groq.age;
  };
}