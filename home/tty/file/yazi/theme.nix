{
  filetype.rules = [
    {
      fg = "#e0def4";
      name = "*";
    }
    {
      fg = "#524f67";
      name = "*/";
    }
    {
      fg = "#9ccfd8";
      mime = "image/*";
    }
    {
      fg = "#f6c177";
      mime = "video/*";
    }
    {
      fg = "#f6c177";
      mime = "audio/*";
    }
    {
      fg = "#eb6f92";
      mime = "application/zip";
    }
    {
      fg = "#eb6f92";
      mime = "application/gzip";
    }
    {
      fg = "#eb6f92";
      mime = "application/x-tar";
    }
    {
      fg = "#eb6f92";
      mime = "application/x-bzip";
    }
    {
      fg = "#eb6f92";
      mime = "application/x-bzip2";
    }
    {
      fg = "#eb6f92";
      mime = "application/x-7z-compressed";
    }
    {
      fg = "#eb6f92";
      mime = "application/x-rar";
    }
  ];

  mgr = {
    border_style.fg = "#524f67";
    border_symbol = "│";

    cwd.fg = "#eb6f92";

    find_keyword = {
      fg = "#f6c177";
      italic = true;
    };
    find_position = {
      bg = "reset";
      fg = "#eb6f92";
      italic = true;
    };

    hovered = {
      bg = "#26233a";
      fg = "#e0def4";
    };
    preview_hovered = {
      underline = true;
    };

    marker_copied = {
      bg = "#f6c177";
      fg = "#f6c177";
    };
    marker_cut = {
      bg = "#B4637A";
      fg = "#B4637A";
    };
    marker_selected = {
      bg = "#9ccfd8";
      fg = "#9ccfd8";
    };

    syntect_theme = "~/.config/yazi/rose-pine.tmTheme";

    tab_active = {
      bg = "#eb6f92";
      fg = "#e0def4";
    };
    tab_inactive = {
      bg = "#2A273F";
      fg = "#e0def4";
    };
    tab_width = 1;
  };

  select = {
    active.fg = "#eb6f92";
    border.fg = "#524f67";
    inactive = {};
  };

  status = {
    # modes
    mode_normal = {
      bg = "#ebbcba";
      bold = true;
      fg = "#191724";
    };
    mode_select = {
      bg = "#9ccfd8";
      bold = true;
      fg = "#191724";
    };
    mode_unset = {
      bg = "#b4637a";
      bold = true;
      fg = "#e0def4";
    };

    # permissions
    permissions_t.fg = "#31748f";
    permissions_s.fg = "#524f67";
    permissions_r.fg = "#f6c177";
    permissions_w.fg = "#B4637A";
    permissions_x.fg = "#9ccfd8";

    # progress bar
    progress_error = {
      bg = "#2A273F";
      fg = "#B4637A";
    };
    progress_label = {
      bold = true;
      fg = "#e0def4";
    };
    progress_normal = {
      bg = "#2A273F";
      fg = "#191724";
    };

    # seperators
    separator_close = "";
    separator_open = "";
    separator_style = {
      bg = "#2A273F";
      fg = "#2A273F";
    };
  };

  tasks = {
    border.fg = "#524f67";
    hovered = {
      underline = true;
    };
    title = {};
  };

  which = {
    cand.fg = "#9ccfd8";
    desc.fg = "#eb6f92";
    # mask.bg = "#313244";
    rest.fg = "#9399b2";
    separator = "  ";
    separator_style.fg = "#585b70";
  };

  input = {
    border.fg = "#524f67";
    selected = {
      reversed = true;
    };
    title = {};
    value = {};
  };

  help = {
    desc.fg = "#9399b2";
    footer = {
      bg = "#e0def4";
      fg = "#2A273F";
    };
    hovered = {
      bg = "#585b70";
      bold = true;
    };
    on.fg = "#eb6f92";
    run.fg = "#9ccfd8";
  };
}
