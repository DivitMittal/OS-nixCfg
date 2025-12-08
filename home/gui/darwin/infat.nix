{
  config,
  pkgs,
  ...
}: let
  homeApps = "${config.home.homeDirectory}/Applications/Home Manager Apps";
  vscodePath = "${homeApps}/Visual Studio Code.app";
  onlyofficePath = "${homeApps}/ONLYOFFICE.app";
  firefoxPath = "${homeApps}/Firefox.app";
  nomacsPath = "${homeApps}/nomacs.app";
  mpvPath = "${homeApps}/mpv.app";
in {
  programs.infat = {
    enable = true;
    package = pkgs.infat;

    autoActivate = true;

    settings = {
      extensions = {
        # Documents
        pdf = "PDF Expert";
        doc = onlyofficePath;
        docx = onlyofficePath;
        odt = onlyofficePath;
        ods = onlyofficePath;
        xls = onlyofficePath;
        xlsx = onlyofficePath;

        # Text and code
        txt = "TextEdit";
        md = "TextEdit";
        org = "TextEdit";
        rst = "TextEdit";
        json = "TextEdit";
        yaml = vscodePath;
        yml = vscodePath;
        toml = vscodePath;
        xml = vscodePath;
        csv = onlyofficePath;

        # Web
        htm = firefoxPath;

        # Images
        png = nomacsPath;
        jpg = nomacsPath;
        jpeg = nomacsPath;
        gif = nomacsPath;
        webp = nomacsPath;
        svg = nomacsPath;

        # Media
        mp3 = mpvPath;
        mp4 = mpvPath;
        mkv = mpvPath;
        avi = mpvPath;
        mov = mpvPath;
        flac = mpvPath;
        wav = mpvPath;
        m4a = mpvPath;
        ogg = mpvPath;
        webm = mpvPath;
      };

      types = {
        plain-text = "TextEdit";
        sourcecode = vscodePath;
        "c-source" = vscodePath;
        "cpp-source" = vscodePath;
        "objc-source" = vscodePath;
        shell = vscodePath;
        makefile = vscodePath;

        # Image types
        image = nomacsPath;
        "raw-image" = nomacsPath;

        # Media types
        audio = mpvPath;
        video = mpvPath;
        movie = mpvPath;
        "mp4-audio" = mpvPath;
        "mp4-movie" = mpvPath;
      };
    };
  };
}
