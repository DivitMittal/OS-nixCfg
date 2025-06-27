{
  buildPythonApplication,
  doCheck ? false,
  fetchPypi,
  lib,
  ...
}:
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
  inherit doCheck;
  meta = with lib; {
    description = "A terminal-based interactive computing environment for Jupyter";
    homepage = "https://github.com/joouha/euporie";
    license = with licenses; [mit];
    maintainers = with maintainers; [DivitMittal];
  };
}