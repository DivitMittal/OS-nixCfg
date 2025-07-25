{
  buildPythonApplication,
  doCheck ? false,
  fetchPypi,
  lib,
  attrs,
  beartype,
  blessed,
  cffi,
  editor,
  inquirer,
  markdown-it-py,
  mdurl,
  pycparser,
  pygments,
  readchar,
  rich,
  runs,
  toml,
  wcwidth,
  xattr,
  xmod,
  ...
}:
buildPythonApplication rec {
  pname = "mac_cleanup";
  version = "3.3.0";
  format = "wheel";
  src = fetchPypi rec {
    inherit pname version format;
    python = "py3";
    dist = python;
    platform = "any";
    hash = "sha256-ZbxmPfggmOzc9hNx/TzHi/bnDZO6piyF0ckb6SyS/MM=";
  };
  propagatedBuildInputs = [
    attrs
    beartype
    blessed
    cffi
    editor
    inquirer
    markdown-it-py
    mdurl
    pycparser
    pygments
    readchar
    rich
    runs
    toml
    wcwidth
    xattr
    xmod
  ];
  inherit doCheck;
  meta = with lib; {
    description = "A python cleanup script for macOS";
    homepage = "https://github.com/mac-cleanup/mac-cleanup-py";
    license = with licenses; [asl20];
    maintainers = with maintainers; [DivitMittal];
  };
}
