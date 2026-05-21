{lib, ...}: {
  home.packages = lib.attrsets.attrValues {
    img2pdf = lib.custom.mkUvxBin "img2pdf" "img2pdf";

    pdf-watermark = lib.custom.mkUvxBin "pdf-watermark" "--with 'cryptography>=3.1' pdf-watermark";
  };
}
