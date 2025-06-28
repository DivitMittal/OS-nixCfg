{
  buildPythonApplication,
  doCheck ? false,
  fetchPypi,
  lib,
  callPackage,
  aiohappyeyeballs,
  aiohttp,
  aiosignal,
  attrs,
  fastjsonschema,
  frozenlist,
  fsspec,
  idna,
  imagesize,
  jsonschema,
  jsonschema-specifications,
  jupyter-client,
  jupyter-core,
  jupytext,
  linkify-it-py,
  markdown-it-py,
  mdit-py-plugins,
  mdurl,
  multidict,
  nbformat,
  packaging,
  pillow,
  platformdirs,
  prompt-toolkit,
  propcache,
  pygments,
  pyperclip,
  python-dateutil,
  pyyaml,
  pyzmq,
  referencing,
  regex,
  rpds-py,
  six,
  tornado,
  traitlets,
  typing-extensions,
  uc-micro-py,
  universal-pathlib,
  wcwidth,
  yarl,
  ...
}: let
  flatlatex = callPackage ../flatlatex/package.nix {};
in
  buildPythonApplication rec {
    pname = "euporie";
    version = "2.8.11";
    format = "wheel";
    src = fetchPypi rec {
      inherit pname version format;
      python = "py3";
      dist = python;
      platform = "any";
      hash = "sha256-rLTnSJYCPAZRQMlJA3QHzUFYAAXxI6Pkq+xPuwGbSfA=";
    };
    propagatedBuildInputs = [
      flatlatex
      aiohappyeyeballs
      aiohttp
      aiosignal
      attrs
      fastjsonschema
      frozenlist
      fsspec
      idna
      imagesize
      jsonschema
      jsonschema-specifications
      jupyter-client
      jupyter-core
      jupytext
      linkify-it-py
      markdown-it-py
      mdit-py-plugins
      mdurl
      multidict
      nbformat
      packaging
      pillow
      platformdirs
      prompt-toolkit
      propcache
      pygments
      pyperclip
      python-dateutil
      pyyaml
      pyzmq
      referencing
      regex
      rpds-py
      six
      tornado
      traitlets
      typing-extensions
      uc-micro-py
      universal-pathlib
      wcwidth
      yarl
    ];
    inherit doCheck;
    meta = with lib; {
      description = "A terminal-based interactive computing environment for Jupyter";
      homepage = "https://github.com/joouha/euporie";
      license = with licenses; [mit];
      maintainers = with maintainers; [DivitMittal];
    };
  }
