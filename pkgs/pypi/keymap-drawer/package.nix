{
  buildPythonApplication,
  lib,
  fetchPypi,
  doCheck ? false,
  pythonOlder,
  annotated-types,
  pcpp,
  platformdirs,
  pydantic,
  pydantic-core,
  pydantic-settings,
  pyparsing,
  python-dotenv,
  pyyaml,
  tree-sitter,
  tree-sitter-grammars,
  typing-extensions,
  typing-inspection,
  ...
}:
buildPythonApplication rec {
  pname = "keymap_drawer";
  version = "0.22.0";
  format = "wheel";
  disabled = pythonOlder "3.10";
  src = fetchPypi rec {
    inherit pname version format;
    platform = "any";
    python = "py3";
    dist = python;
    hash = "sha256-OFTtM5GMCVnLYkRbntgatH87BpWMhx6+eVYIFV3ph3U=";
  };
  propagatedBuildInputs = [
    annotated-types
    pcpp
    platformdirs
    pydantic
    pydantic-core
    pydantic-settings
    pyparsing
    python-dotenv
    pyyaml
    tree-sitter
    typing-extensions
    typing-inspection
    tree-sitter-grammars.tree-sitter-devicetree
  ];
  inherit doCheck;
  meta = with lib; {
    description = "A tool to visualize QMK/ZMK/kanata keymaps";
    homepage = "https://github.com/caksoylar/keymap-drawer";
    license = with licenses; [mit];
    maintainers = with maintainers; [DivitMittal];
  };
}