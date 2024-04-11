{
  core = {
    editor       = "nvim";
    autocrlf     = "input";
    ignorecase   = false;
    excludesfile = "~/.config/git/ignore";
  };

  init = {
    defaultBranch = "master";
  };

  push = {
    default       = "simple";
    followTags    = true;
  };

  fetch = {
    prune         = true;
  };

  grep = {
    lineNumber    = true;
  };

  help = {
    autocorrect   = "1";
  };

  merge = {
    conflictstyle = "diff3";
  };

  color = {
    ui = "auto";
  };
}
