{
  input = {
    cd_offset = [ 0 2 50 3 ]; cd_origin = "top-center"; cd_title = "Change directory:";
    create_offset = [ 0 2 50 3 ]; create_origin = "top-center"; create_title = "Create:";
    delete_offset = [ 0 2 50 3 ]; delete_origin = "top-center"; delete_title = "Delete {n} selected file{s} permanently? (y/N)";
    filter_offset = [ 0 2 50 3 ]; filter_origin = "top-center"; filter_title = "Filter:";
    find_offset = [ 0 2 50 3 ]; find_origin = "top-center"; find_title = [ "Find next:" "Find previous:" ];
    overwrite_offset = [ 0 2 50 3 ]; overwrite_origin = "top-center"; overwrite_title = "Overwrite an existing file? (y/N)";
    quit_offset = [ 0 2 50 3 ]; quit_origin = "top-center"; quit_title = "{n} task{s} running, sure to quit? (y/N)";
    rename_offset = [ 0 1 50 3 ]; rename_origin = "hovered"; rename_title = "Rename:";
    search_offset = [ 0 2 50 3 ]; search_origin = "top-center"; search_title = "Search via {n}:";
    shell_offset = [ 0 2 50 3 ]; shell_origin = "top-center"; shell_title = [ "Shell:" "Shell (block):" ];
    trash_offset = [ 0 2 50 3 ]; trash_origin = "top-center"; trash_title = "Move {n} selected file{s} to trash? (y/N)";
  };
  log = {
    enabled = false;
  };
  manager = {
    linemode = "none";
    ratio = [ 1 4 3 ];
    show_hidden = true;
    show_symlink = false;
    sort_by = "alphabetical";
    sort_dir_first = false;
    sort_reverse = false;
    sort_sensitive = false;
  };
  open = {
    rules = [
      { name = "*/"; use = [ "edit" "open" "reveal" ]; }
      { mime = "text/*"; use = [ "edit" "reveal" ]; }
      { mime = "image/*"; use = [ "open" "reveal" ]; }
      { mime = "video/*"; use = [ "play" "reveal" ]; }
      { mime = "audio/*"; use = [ "play" "reveal" ]; }
      { mime = "inode/x-empty"; use = [ "edit" "reveal" ]; }
      { mime = "application/json"; use = [ "edit" "reveal" ]; }
      { mime = "*/javascript"; use = [ "edit" "reveal" ]; }
      { mime = "application/zip"; use = [ "extract" "reveal" ]; }
      { mime = "application/gzip"; use = [ "extract" "reveal" ]; }
      { mime = "application/x-tar"; use = [ "extract" "reveal" ]; }
      { mime = "application/x-bzip"; use = [ "extract" "reveal" ]; }
      { mime = "application/x-bzip2"; use = [ "extract" "reveal" ]; }
      { mime = "application/x-7z-compressed"; use = [ "extract" "reveal" ]; }
      { mime = "application/x-rar"; use = [ "extract" "reveal" ]; }
      { mime = "application/xz"; use = [ "extract" "reveal" ]; }
      { mime = "*"; use = [ "open" "reveal" ]; }
    ];
  };
  opener = {
    edit = [
      { block = true; for = "unix"; run = "$EDITOR \"$@\""; }
      { for = "windows"; orphan = true; run = "code \"%*\""; }
    ];
    extract = [
      { desc = "Extract here"; for = "unix"; run = "unar \"$1\""; }
      { desc = "Extract here"; for = "windows"; run = "unar \"%1\""; }
    ];
    open = [
      { desc = "Open"; for = "linux"; run = "xdg-open \"$@\""; }
      { desc = "Open"; for = "macos"; run = "open \"$@\""; }
      { desc = "Open"; for = "windows"; orphan = true; run = "start \"\" \"%1\""; }
    ];
    play = [
      { for = "unix"; orphan = true; run = "mpv \"$@\""; }
      { for = "windows"; orphan = true; run = "mpv \"%1\""; }
      { block = true; desc = "Show media info"; for = "unix"; run = "mediainfo \"$1\"; echo \"Press enter to exit\"; read"; }
    ];
    reveal = [
      { desc = "Reveal"; for = "macos"; run = "open -R \"$1\""; }
      { desc = "Reveal"; for = "windows"; orphan = true; run = "explorer /select, \"%1\""; }
      { block = true; desc = "Show EXIF"; for = "unix"; run = "exiftool \"$1\"; echo \"Press enter to exit\"; read"; }
    ];
  };
  plugin = {
    preloaders = [
      { cond = "!mime"; multi = true; name = "*"; prio = "high"; run = "mime"; }
      { mime = "image/vnd.djvu"; run = "noop"; }
      { mime = "image/*"; run = "image"; }
      { mime = "video/*"; run = "video"; }
      { mime = "application/pdf"; run = "pdf"; }
    ];
    prepend_previewers = [
      { mime = "application/*zip"; run = "ouch"; }
      { mime = "application/x-tar"; run = "ouch"; }
      { mime = "application/x-bzip2"; run = "ouch"; }
      { mime = "application/x-7z-compressed"; run = "ouch"; }
      { mime = "application/x-rar"; run = "ouch"; }
      { mime = "application/x-xz"; run = "ouch"; }
    ];
    previewers = [
      { name = "*/"; run = "folder"; sync = true; }
      { mime = "text/*"; run = "code"; }
      { mime = "*/xml"; run = "code"; }
      { mime = "*/javascript"; run = "code"; }
      { mime = "*/x-wine-extension-ini"; run = "code"; }
      { mime = "application/json"; run = "json"; }
      { mime = "image/vnd.djvu"; run = "noop"; }
      { mime = "image/*"; run = "image"; }
      { mime = "video/*"; run = "video"; }
      { mime = "application/pdf"; run = "pdf"; }
      { mime = "application/zip"; run = "archive"; }
      { mime = "application/gzip"; run = "archive"; }
      { mime = "application/x-tar"; run = "archive"; }
      { mime = "application/x-bzip"; run = "archive"; }
      { mime = "application/x-bzip2"; run = "archive"; }
      { mime = "application/x-7z-compressed"; run = "archive"; }
      { mime = "application/x-rar"; run = "archive"; }
      { mime = "application/xz"; run = "archive"; }
      { name = "*"; run = "file"; }
    ];
  };
  preview = {
    cache_dir = "";
    image_filter = "triangle";
    image_quality = 75;
    max_height = 900;
    max_width = 600;
    sixel_fraction = 15;
    tab_size = 2;
    ueberzug_offset = [ 0 0 0 0 ]; ueberzug_scale = 1; };
  select = {
    open_offset = [ 0 1 50 7 ]; open_origin = "hovered"; open_title = "Open with:";
  };
  tasks = {
    bizarre_retry = 5;
    image_alloc = 536870912; image_bound = [ 0 0 ];
    macro_workers = 25;
    micro_workers = 10;
    suppress_preload = false;
  };
}