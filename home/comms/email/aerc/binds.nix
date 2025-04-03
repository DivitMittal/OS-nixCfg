{
  compose = {
    "?" = ":help keys<Enter>";
    "!" = ":term<Enter>";
    "$complete" = "<C-o>";
    "$ex" = "<C-x>";
    "$noinherit" = "true";
    "<C-n>" = ":next-tab<Enter>";
    "<C-p>" = ":prev-tab<Enter>";
    "<backtab>" = ":prev-field<Enter>";
    "<tab>" = ":next-field<Enter>";
  };
  "compose::editor" = {
    "$ex" = "<C-x>";
    "$noinherit" = "true";
    "<A-e>" = ":next-field<Enter>";
    "<A-u>" = ":prev-field<Enter>";
    "<C-n>" = ":next-tab<Enter>";
    "<C-p>" = ":prev-tab<Enter>";
  };
  "compose::review" = {
    a = ":attach<space>";
    d = ":detach<space>";
    e = ":edit<Enter>";
    n = ":abort<Enter>";
    p = ":postpone<Enter>";
    q = ":choose -o d discard abort -o p postpone postpone<Enter>";
    v = ":preview<Enter>";
    y = ":send<Enter>";
  };

  messages = {
    "<C-n>" = ":next-tab<Enter>";
    "<C-p>" = ":prev-tab<Enter>";
    "?" = ":help keys<Enter>";
    "!" = ":term<space>";
    "/" = ":search<space>";
    "<C-d>" = ":next 50%<Enter>";
    "<C-u>" = ":prev 50%<Enter>";
    "<Down>" = ":next<Enter>";
    "<Enter>" = ":view<Enter>";
    "<Esc>" = ":clear<Enter>";
    "<PgDn>" = ":next 100%<Enter>";
    "<PgUp>" = ":prev 100%<Enter>";
    "<Space>" = ":mark -t<Enter>:next<Enter>";
    "<Up>" = ":prev<Enter>";
    "<tab>" = ":fold -t<Enter>";
    A = ":unmark -a<Enter>:mark -T<Enter>:archive flat<Enter>";
    C = ":collapse-folder<Enter>";
    D = ":delete<Enter>";
    E = ":next-folder<Enter>";
    G = ":select -1<Enter>";
    N = ":prev-result<Enter>";
    O = ":expand-folder<Enter>";
    Rq = ":reply -q<Enter>";
    Rr = ":reply<Enter>";
    S = ":vsplit<Enter>";
    T = ":toggle-threads<Enter>";
    U = ":prev-folder<Enter>";
    V = ":mark -v<Enter>";
    a = ":archive flat<Enter>";
    c = ":compose<Enter>";
    d = ":prompt 'Really delete this message?' 'delete-message'<Enter>";
    f = ":filter<space>";
    g = ":select 0<Enter>";
    n = ":next-result<Enter>";
    pa = ":patch apply <Tab>";
    pb = ":patch rebase<Enter>";
    pd = ":patch drop <Tab>";
    pl = ":patch list<Enter>";
    ps = ":patch switch <Tab>";
    pt = ":patch term<Enter>";
    rq = ":reply -aq<Enter>";
    rr = ":reply -a<Enter>";
    s = ":split<Enter>";
    v = ":mark -t<Enter>";
    zM = ":fold -a<Enter>";
    zR = ":unfold -a<Enter>";
    za = ":fold -t<Enter>";
    zc = ":fold<Enter>";
    zo = ":unfold<Enter>";
    "|" = ":pipe<space>";
  };
  "messages:folder=Drafts" = {"<Enter>" = ":recall<Enter>";};

  terminal = {
    "$ex" = "<C-x>";
    "$noinherit" = "true";
    "<C-n>" = ":next-tab<Enter>";
    "<C-p>" = ":prev-tab<Enter>";
  };

  view = {
    "<C-n>" = ":next-tab<Enter>";
    "<C-p>" = ":prev-tab<Enter>";
    "?" = ":help keys<Enter>";
    "!" = ":term<Enter>";
    "/" = ":toggle-key-passthrough<Enter>/";
    "<C-l>" = ":open-link <space>";
    "<Esc>" = ":close<Enter>";
    "<Left>" = ":prev<Enter>";
    "<Right>" = ":next<Enter>";
    A = ":archive flat<Enter>";
    D = ":delete<Enter>";
    E = ":next-part<Enter>";
    H = ":toggle-headers<Enter>";
    Rq = ":reply -q<Enter>";
    Rr = ":reply<Enter>";
    S = ":save<space>";
    U = ":prev-part<Enter>";
    f = ":forward<Enter>";
    o = ":open<Enter>";
    rq = ":reply -aq<Enter>";
    rr = ":reply -a<Enter>";
    "|" = ":pipe<space>";
  };
  "view::passthrough" = {
    "$ex" = "<C-x>";
    "$noinherit" = "true";
    "<Esc>" = ":toggle-key-passthrough<Enter>";
  };
}
