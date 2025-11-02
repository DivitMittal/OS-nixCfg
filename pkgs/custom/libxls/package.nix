{
  lib,
  stdenv,
  fetchurl,
}:
stdenv.mkDerivation rec {
  pname = "libxls";
  version = "1.6.3";

  # Use release tarball instead of GitHub source - includes pre-generated configure
  src = fetchurl {
    url = "https://github.com/libxls/libxls/releases/download/v${version}/libxls-${version}.tar.gz";
    hash = "sha256-svuDbqC1JTo1L7XKVXQuKfBvlPlCHFuO7M7y5dQ/Yiw=";
  };

  enableParallelBuilding = true;

  meta = with lib; {
    description = "Extract Cell Data From Excel xls files";
    homepage = "https://github.com/libxls/libxls";
    license = licenses.bsd2;
    maintainers = [];
    mainProgram = "xls2csv";
    platforms = platforms.unix;
  };
}
