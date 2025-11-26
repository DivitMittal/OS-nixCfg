{pkgs}: {
  log.enabled = false;

  mgr = {
    ratio = [1 3 3];
    linemode = "permissions";
    show_hidden = true;
    show_symlink = false;
    sort_by = "alphabetical";
    sort_dir_first = true;
    sort_reverse = false;
    mouse_events = ["click" "scroll"];
    sort_sensitive = false;
  };

  open.rules = [
    ## Directory
    {
      name = "*/";
      use = ["open" "reveal" "look"];
    }
    ## Empty file
    {
      mime = "inode/x-empty";
      use = ["edit" "reveal"];
    }
    ## HTML Documents
    {
      name = "*.{html,htm}";
      use = ["firefox" "chrome" "open" "edit" "editVS" "reveal"];
    }
    ## Code
    {
      mime = "text/*";
      use = ["edit" "editVS" "open" "reveal"];
    }
    {
      mime = "application/json";
      use = ["edit" "editVS" "reveal"];
    }
    {
      mime = "*/javascript";
      use = ["edit" "editVS" "reveal"];
    }
    ## Media
    {
      mime = "image/*";
      use = ["nomacs" "open" "reveal" "look"];
    }
    {
      mime = "video/*";
      use = ["play" "reveal" "look"];
    }
    {
      mime = "audio/*";
      use = ["play" "reveal" "look"];
    }
    {
      mime = "application/pdf";
      use = ["zathura" "reveal" "look"];
    }
    ## Ebook Documents
    {
      name = "*.{epub,mobi,azw,azw3,fb2,lrf,pdb,cbz,cbr}";
      use = ["ebook-viewer" "open" "reveal"];
    }
    ## Office Documents - Spreadsheets
    {
      name = "*.{xlsx,xls,ods}";
      use = ["excel" "libreoffice" "onlyoffice" "reveal"];
    }
    ## Office Documents - Word
    {
      name = "*.{docx,odt}";
      use = ["doxx" "word" "libreoffice" "onlyoffice" "reveal"];
    }
    ## Office Documents - Presentations
    {
      name = "*.{pptx,ppt,odp}";
      use = ["libreoffice" "onlyoffice" "reveal"];
    }
    ## Ableton Live Files
    {
      name = "*.{als,alp,adg,adv,agr,amxd}";
      use = ["ableton" "reveal"];
    }
    ## MIDI Files
    {
      name = "*.{mid,midi}";
      use = ["guitarpro" "musescore" "ableton" "reveal"];
    }
    ## archives
    {
      mime = "application/zip";
      use = ["extract" "reveal"];
    }
    {
      mime = "application/gzip";
      use = ["extract" "reveal"];
    }
    {
      mime = "application/x-tar";
      use = ["extract" "reveal"];
    }
    {
      mime = "application/x-bzip";
      use = ["extract" "reveal"];
    }
    {
      mime = "application/x-bzip2";
      use = ["extract" "reveal"];
    }
    {
      mime = "application/x-7z-compressed";
      use = ["extract" "reveal"];
    }
    {
      mime = "application/x-rar";
      use = ["extract" "reveal"];
    }
    {
      mime = "application/xz";
      use = ["extract" "reveal"];
    }
    ## fallback for all other files
    {
      name = "*";
      use = ["edit" "open" "reveal" "look"];
    }
  ];

  opener = {
    edit = [
      {
        for = "unix";
        desc = "Edit via $EDITOR";
        run = "$EDITOR \"$@\"";
        block = true;
      }
      {
        for = "windows";
        desc = "Edit via $EDITOR";
        run = "%EDITOR% \"%*\"";
        orphan = true;
        block = true;
      }
    ];
    editVS = [
      {
        for = "unix";
        desc = "Edit via VSCode";
        run = "code \"$@\"";
        block = true;
      }
      {
        for = "windows";
        desc = "Edit via VSCode";
        run = "code \"%*\"";
        orphan = true;
      }
    ];
    open = [
      {
        for = "linux";
        desc = "Default Open";
        run = "xdg-open \"$@\"";
      }
      {
        for = "macos";
        desc = "Default Open";
        run = "open \"$@\"";
      }
      {
        for = "windows";
        desc = "Default Open";
        run = "start \"\" \"%1\"";
        orphan = true;
      }
    ];
    extract = [
      {
        for = "unix";
        desc = "Extract Here";
        run = "ouch d \"$1\"";
      }
      {
        for = "windows";
        desc = "Extract Here";
        run = "ouch d \"%1\"";
      }
    ];
    play = [
      {
        for = "linux";
        desc = "Play via mpv";
        run = "mpv --force-window \"$@\"";
        orphan = true;
      }
      {
        for = "macos";
        desc = "Play via mpv";
        run = "stolendata-mpv --force-window \"$@\"";
        orphan = true;
      }
      {
        for = "windows";
        desc = "Play via mpv";
        run = "mpv --force-window \"%1\"";
        orphan = true;
      }
    ];
    reveal = [
      {
        for = "macos";
        desc = "Finder reveal";
        run = "open -R \"$1\"";
      }
      {
        for = "windows";
        desc = "Explorer reveal";
        run = "explorer /select, \"%1\"";
        orphan = true;
      }
    ];
    look = [
      {
        for = "macos";
        desc = "QuickLook";
        run = "qlmanage -p \"$@\"";
      }
    ];
    zathura = [
      {
        for = "unix";
        desc = "Zathura PDF Viewer";
        run = "zathura \"$@\"";
      }
      {
        for = "windows";
        desc = "Zathura PDF Viewer";
        run = "zathura \"%1\"";
      }
    ];
    ebook-viewer = let
      calibrePath =
        if pkgs.stdenvNoCC.hostPlatform.isDarwin
        then "${pkgs.brewCasks.calibre}/Applications/calibre.app/Contents/MacOS"
        else "";
    in [
      {
        for = "linux";
        desc = "Calibre Ebook Viewer";
        run = "ebook-viewer \"$@\"";
        orphan = true;
      }
      {
        for = "macos";
        desc = "Calibre Ebook Viewer";
        run = "${calibrePath}/ebook-viewer \"$@\"";
        orphan = true;
      }
      {
        for = "windows";
        desc = "Calibre Ebook Viewer";
        run = "ebook-viewer \"%*\"";
        orphan = true;
      }
    ];
    onlyoffice = let
      linuxPath =
        if pkgs.stdenvNoCC.hostPlatform.isLinux
        then "${pkgs.onlyoffice-bin}/bin/onlyoffice-desktopeditors"
        else "onlyoffice-desktopeditors";
    in [
      {
        for = "linux";
        desc = "OnlyOffice";
        run = "${linuxPath} \"$@\"";
        orphan = true;
      }
      {
        for = "macos";
        desc = "OnlyOffice";
        run = "open -a 'ONLYOFFICE' \"$@\"";
        orphan = true;
      }
      {
        for = "windows";
        desc = "OnlyOffice";
        run = "start \"\" \"ONLYOFFICE Desktop Editors.exe\" \"%*\"";
        orphan = true;
      }
    ];
    excel = [
      {
        for = "macos";
        desc = "Microsoft Excel";
        run = "open -a 'Microsoft Excel' \"$@\"";
        orphan = true;
      }
      {
        for = "windows";
        desc = "Microsoft Excel";
        run = "start \"\" \"excel.exe\" \"%*\"";
        orphan = true;
      }
    ];
    word = [
      {
        for = "macos";
        desc = "Microsoft Word";
        run = "open -a 'Microsoft Word' \"$@\"";
        orphan = true;
      }
      {
        for = "windows";
        desc = "Microsoft Word";
        run = "start \"\" \"winword.exe\" \"%*\"";
        orphan = true;
      }
    ];
    doxx = [
      {
        for = "unix";
        desc = "Doxx TUI Word Viewer";
        run = "${pkgs.doxx}/bin/doxx \"$@\"";
        block = true;
      }
      {
        for = "macos";
        desc = "Doxx TUI Word Viewer";
        run = "${pkgs.doxx}/bin/doxx \"$@\"";
        block = true;
      }
      {
        for = "windows";
        desc = "Doxx TUI Word Viewer";
        run = "doxx \"%*\"";
        block = true;
      }
    ];
    libreoffice = let
      linuxPath =
        if pkgs.stdenvNoCC.hostPlatform.isLinux
        then "${pkgs.libreoffice}/bin/libreoffice"
        else "libreoffice";
    in [
      {
        for = "linux";
        desc = "LibreOffice";
        run = "${linuxPath} \"$@\"";
        orphan = true;
      }
      {
        for = "macos";
        desc = "LibreOffice";
        run = "open -a 'LibreOffice' \"$@\"";
        orphan = true;
      }
      {
        for = "windows";
        desc = "LibreOffice";
        run = "start \"\" \"soffice.exe\" \"%*\"";
        orphan = true;
      }
    ];
    chrome = [
      {
        for = "linux";
        desc = "Google Chrome";
        run = "google-chrome \"$@\"";
        orphan = true;
      }
      {
        for = "macos";
        desc = "Google Chrome";
        run = "open -a 'Google Chrome' \"$@\"";
        orphan = true;
      }
      {
        for = "windows";
        desc = "Google Chrome";
        run = "start \"\" \"chrome.exe\" \"%*\"";
        orphan = true;
      }
    ];
    firefox = [
      {
        for = "linux";
        desc = "Mozilla Firefox";
        run = "firefox \"$@\"";
        orphan = true;
      }
      {
        for = "macos";
        desc = "Mozilla Firefox";
        run = "open -a 'Firefox' \"$@\"";
        orphan = true;
      }
      {
        for = "windows";
        desc = "Mozilla Firefox";
        run = "start \"\" \"firefox.exe\" \"%*\"";
        orphan = true;
      }
    ];
    ableton = [
      {
        for = "macos";
        desc = "Ableton Live";
        run = "open -a 'Ableton Live 12 Suite' \"$@\"";
        orphan = true;
      }
      {
        for = "windows";
        desc = "Ableton Live";
        run = "start \"\" \"Ableton Live 12 Suite.exe\" \"%*\"";
        orphan = true;
      }
    ];
    guitarpro = [
      {
        for = "macos";
        desc = "Guitar Pro 8";
        run = "open -a 'Guitar Pro 8' \"$@\"";
        orphan = true;
      }
      {
        for = "windows";
        desc = "Guitar Pro 8";
        run = "start \"\" \"GuitarPro8.exe\" \"%*\"";
        orphan = true;
      }
    ];
    musescore = [
      {
        for = "linux";
        desc = "MuseScore";
        run = "musescore \"$@\"";
        orphan = true;
      }
      {
        for = "macos";
        desc = "MuseScore";
        run = "open -a 'MuseScore 4' \"$@\"";
        orphan = true;
      }
      {
        for = "windows";
        desc = "MuseScore";
        run = "start \"\" \"MuseScore4.exe\" \"%*\"";
        orphan = true;
      }
    ];
    nomacs = [
      {
        for = "linux";
        desc = "nomacs Image Viewer";
        run = "nomacs \"$@\"";
        orphan = true;
      }
      {
        for = "macos";
        desc = "nomacs Image Viewer";
        run = "nomacs \"$@\"";
        orphan = true;
      }
      {
        for = "windows";
        desc = "nomacs Image Viewer";
        run = "nomacs \"%*\"";
        orphan = true;
      }
    ];
  };

  plugin = {
    preloaders = [
      ## Images
      {
        mime = "image/{avif,hei?,jxl,svg+xml}";
        run = "magick";
      }
      {
        mime = "image/vnd.djvu";
        run = "noop";
      }
      {
        mime = "image/*";
        run = "image";
      }
      ## Video
      {
        mime = "video/*";
        run = "video";
      }
      ## PDF
      {
        mime = "application/pdf";
        run = "pdf";
      }
      ## Font
      {
        mime = "font/*";
        run = "font";
      }
      {
        mime = "application/ms-opentype";
        run = "font";
      }
    ];

    spotters = [
      ## Directory
      {
        name = "*/";
        run = "folder";
      }
      ## Code
      {
        mime = "text/*";
        run = "code";
      }
      {
        mime = "*/{xml,javascript,wine-extension-ini}";
        run = "code";
      }
      ## Image
      {
        mime = "image/{avif,hei?,jxl,svg+xml}";
        run = "magick";
      }
      {
        mime = "image/*";
        run = "image";
      }
      ## Video
      {
        mime = "video/*";
        run = "video";
      }
      ## File Fallback
      {
        name = "*";
        run = "file";
      }
    ];

    previewers = let
      # Code previewers
      codeMimes = ["text/*" "*/xml" "*/javascript" "*/x-wine-extension-ini"];
      codePreviewers =
        map (mime: {
          inherit mime;
          run = "code";
        })
        codeMimes;

      # Archive previewers (mime-based)
      archiveMimes = [
        "application/zip"
        "application/gzip"
        "application/x-tar"
        "application/x-bzip"
        "application/x-bzip2"
        "application/x-7z-compressed"
        "application/x-rar"
        "application/xz"
        "application/{debian*-package,redhat-package-manager,rpm,android.package-archive}"
        "application/{iso9660-image,qemu-disk,ms-wim,apple-diskimage}"
        "application/virtualbox-{vhd,vhdx}"
      ];
      archiveMimePreviewers =
        map (mime: {
          inherit mime;
          run = "archive";
        })
        archiveMimes;

      # Archive previewers (name-based)
      archiveNames = ["*.{AppImage,appimage}" "*.{img,fat,ext,ext2,ext3,ext4,squashfs,ntfs,hfs,hfsx}"];
      archiveNamePreviewers =
        map (name: {
          inherit name;
          run = "archive";
        })
        archiveNames;

      # Font previewers
      fontMimes = ["font/*" "application/ms-opentype"];
      fontPreviewers =
        map (mime: {
          inherit mime;
          run = "font";
        })
        fontMimes;
    in
      [
        ## Directories
        {
          name = "*/";
          run = "folder";
          sync = true;
        }
        ## Empty File
        {
          mime = "inode/empty";
          run = "empty";
        }
      ]
      ++ codePreviewers
      ++ [
        {
          mime = "application/{json, ndjson}";
          run = "json";
        }
        ## Images
        {
          mime = "image/{avif,hei?,jxl,svg+xml}";
          run = "magick";
        }
        {
          mime = "image/vnd.djvu";
          run = "noop";
        }
        {
          mime = "image/*";
          run = "image";
        }
        ## Video
        {
          mime = "video/*";
          run = "video";
        }
        ## PDF
        {
          mime = "application/pdf";
          run = "pdf";
        }
      ]
      ++ archiveMimePreviewers
      ++ archiveNamePreviewers
      ++ fontPreviewers;

    prepend_previewers = let
      # Glow style configuration
      glamourStyles = pkgs.fetchFromGitHub {
        owner = "charmbracelet";
        repo = "glamour";
        rev = "0af1a2d9bc9e9d52422b26440fe218c69f9afbdd";
        hash = "sha256-ZnkYUVtpGGfZHOKx3I4mnMYaXGiMoSNuviz+ooENmbc=";
      };
      glowStyle = "${glamourStyles}/styles/pink.json";

      # Markitdown → Glow previewers for documents
      markitdownCmd = "piper -- ${pkgs.uv}/bin/uvx markitdown[all] \"$1\" 2>/dev/null | CLICOLOR_FORCE=1 ${pkgs.glow}/bin/glow --style ${glowStyle} -w=$w - 2>/dev/null";
      markitdownPatterns = ["*.csv" "*.tsv" "*.{xlsx,xls,ods}" "*.{docx,odt}" "*.{pptx,ppt,odp}" "*.{html,htm}" "*.xml" "*.epub" "*.ipynb"];
      markitdownPreviewers =
        map (pattern: {
          name = pattern;
          run = markitdownCmd;
        })
        markitdownPatterns;

      # Ouch archive previewers
      ouchMimes = ["application/*zip" "application/x-tar" "application/x-bzip2" "application/x-7z-compressed" "application/x-rar" "application/x-xz"];
      ouchPreviewers =
        map (mime: {
          inherit mime;
          run = "ouch";
        })
        ouchMimes;
    in
      markitdownPreviewers
      ++ ouchPreviewers
      ++ [
        ## Other
        {
          name = "*.md";
          run = "piper -- CLICOLOR_FORCE=1 ${pkgs.glow}/bin/glow --style ${glowStyle} -w=$w \"$1\"";
        }
      ];

    append_previewers = [
      ## fallback for all other files
      {
        name = "*";
        run = "piper -- ${pkgs.hexyl}/bin/hexyl --border=none --terminal-width=$w \"$1\"";
      }
    ];

    prepend_fetchers = [
      {
        name = "*";
        id = "git";
        run = "git";
        prio = "low";
      }
      {
        name = "*/";
        id = "git";
        run = "git";
        prio = "low";
      }
    ];
  };

  select = {
    open_offset = [0 1 50 7];
    open_origin = "hovered";
    open_title = "Open with:";
  };

  input = {
    cd_offset = [0 2 50 3];
    cd_origin = "top-center";
    cd_title = "Change directory:";
    create_offset = [0 2 50 3];
    create_origin = "top-center";
    create_title = [
      "Create:"
      "Create (dir):"
    ];
    trash_offset = [0 2 50 3];
    trash_origin = "top-center";
    trash_title = "move {n} selected file{s} to trash? (y/n)";
    delete_offset = [0 2 50 3];
    delete_origin = "top-center";
    delete_title = "Delete {n} selected file{s} permanently? (y/N)";
    filter_offset = [0 2 50 3];
    filter_origin = "top-center";
    filter_title = "Filter:";
    find_offset = [0 2 50 3];
    find_origin = "top-center";
    find_title = [
      "Find next:"
      "Find previous:"
    ];
    overwrite_offset = [0 2 50 3];
    overwrite_origin = "top-center";
    overwrite_title = "Overwrite an existing file? (y/N)";
    quit_offset = [0 2 50 3];
    quit_origin = "top-center";
    quit_title = "{n} task{s} running, sure to quit? (y/N)";
    rename_offset = [0 1 50 3];
    rename_origin = "hovered";
    rename_title = "Rename:";
    search_offset = [0 2 50 3];
    search_origin = "top-center";
    search_title = "Search via {n}:";
    shell_offset = [0 2 50 3];
    shell_origin = "top-center";
    shell_title = [
      "Shell:"
      "Shell (block):"
    ];
  };

  preview = {
    wrap = "no";
    tab_size = 2;
    cache_dir = "";
    image_filter = "nearest";
    image_delay = 100;
    image_quality = 50;
    max_height = 2000;
    max_width = 2000;
    sixel_fraction = 15;
    ueberzug_offset = [0 0 0 0];
    ueberzug_scale = 1;
  };

  tasks = {
    bizarre_retry = 5;
    image_alloc = 536870912;
    image_bound = [0 0];
    macro_workers = 25;
    micro_workers = 10;
    suppress_preload = false;
  };
}
