{lib, ...}: {
  home.packages = lib.attrsets.attrValues {
    img2pdf = lib.custom.mkUvxBin "img2pdf" "img2pdf";

    pdf-watermark = lib.custom.mkUvxBin "pdf-watermark" "--with 'cryptography>=3.1' pdf-watermark";

    ## Euporie (Jupyter client)
    euporie-notebook = lib.custom.mkUvxBin "euporie-notebook" "--from euporie euporie-notebook";
    euporie-preview = lib.custom.mkUvxBin "euporie-preview" "--from euporie euporie-preview";
    euporie = lib.custom.mkUvxBin "euporie" "--from euporie euporie";
  };
}
