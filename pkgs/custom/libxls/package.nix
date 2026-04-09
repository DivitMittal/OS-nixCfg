{
  lib,
  stdenv,
  sources,
}:
stdenv.mkDerivation {
  pname = "libxls";
  # src.prefix = "v" in nvfetcher.toml strips the "v" — version is bare (e.g. "1.6.3")
  # Use release tarball instead of GitHub source - includes pre-generated configure
  inherit (sources.libxls) version src;

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
