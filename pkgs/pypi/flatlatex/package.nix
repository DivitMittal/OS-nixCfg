{
  buildPythonPackage,
  fetchPypi,
  lib,
}:

buildPythonPackage rec {
  pname = "flatlatex";
  version = "0.15";
  format = "wheel";

  src = fetchPypi rec {
    inherit pname version format;
    python = "py3";
    dist = python;
    platform = "any";
    hash = "sha256-TPPtnBuDeTX9eUaN27JaxWEyVGejqdwFCAWyl+sLJcY=";
  };

  meta = with lib; {
    description = "A basic converter from LaTeX math to human readable text math using unicode characters"; # Placeholder: Add actual description
    maintainers = with maintainers; [ DivitMittal ];
  };
}