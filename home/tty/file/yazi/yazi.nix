{
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
      use = ["open" "reveal" "look"];
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
      use = ["edit" "editVS" "open" "reveal" "look"];
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

    previewers = [
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
      ## Code
      {
        mime = "text/*";
        run = "code";
      }
      {
        mime = "*/xml";
        run = "code";
      }
      {
        mime = "*/javascript";
        run = "code";
      }
      {
        mime = "*/x-wine-extension-ini";
        run = "code";
      }
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
      ## Archives
      {
        mime = "application/zip";
        run = "archive";
      }
      {
        mime = "application/gzip";
        run = "archive";
      }
      {
        mime = "application/x-tar";
        run = "archive";
      }
      {
        mime = "application/x-bzip";
        run = "archive";
      }
      {
        mime = "application/x-bzip2";
        run = "archive";
      }
      {
        mime = "application/x-7z-compressed";
        run = "archive";
      }
      {
        mime = "application/x-rar";
        run = "archive";
      }
      {
        mime = "application/xz";
        run = "archive";
      }
      ## Package Archives
      {
        mime = "application/{debian*-package,redhat-package-manager,rpm,android.package-archive}";
        run = "archive";
      }
      {
        name = "*.{AppImage,appimage}";
        run = "archive";
      }
      ## Virtual Disk
      {
        mime = "application/{iso9660-image,qemu-disk,ms-wim,apple-diskimage}";
        run = "archive";
      }
      {
        mime = "application/virtualbox-{vhd,vhdx}";
        run = "archive";
      }
      {
        name = "*.{img,fat,ext,ext2,ext3,ext4,squashfs,ntfs,hfs,hfsx}";
        run = "archive";
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

    prepend_previewers = [
      ## Archives
      {
        mime = "application/*zip";
        run = "ouch";
      }
      {
        mime = "application/x-tar";
        run = "ouch";
      }
      {
        mime = "application/x-bzip2";
        run = "ouch";
      }
      {
        mime = "application/x-7z-compressed";
        run = "ouch";
      }
      {
        mime = "application/x-rar";
        run = "ouch";
      }
      {
        mime = "application/x-xz";
        run = "ouch";
      }
      ## Other
      {
        name = "*.csv";
        run = "piper -- rich -w $w \"$1\"";
      }
      {
        name = "*.md";
        run = "piper -- CLICOLOR_FORCE=1 glow -w=$w -s=dark \"$1\"";
      }
      {
        name = "*.ipynb";
        run = "piper -- rich -w $w \"$1\"";
      }
    ];

    append_previewers = [
      ## fallback for all other files
      {
        name = "*";
        run = "piper -- hexyl --border=none --terminal-width=$w \"$1\"";
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
