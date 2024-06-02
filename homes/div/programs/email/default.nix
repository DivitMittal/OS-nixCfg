{ config, ... }:

{
  programs = {
    aerc = {
      enable = true;

      extraConfig = {
        general = {
          unsafe-accounts-conf = true;
          default-menu-cmd = "fzf --multi";
        };

        ui = {
          index-columns = "name<17,flags>4,subject<*,date<20";
          sidebar-width = 30;
          mouse-enabled = true;
          styleset-name = "pink";
          fuzzy-complete = true;
          icon-unencrypted = "";
          icon-encrypted = "✔";
          icon-signed = "✔";
          icon-signed-encrypted = "✔";
          icon-unknown = "✘";
          icon-invalid = "⚠";
        };

        filters = {
          "text/plain" = "colorize";
          "text/calendar" = "calendar";
          "message/delivery-status" = "colorize";
          "message/rfc822" = "colorize";
          "text/html" = "html | colorize";
          "application/x-sh" = "bat -fP -l sh";
        };

        openers = {
          "x-scheme-handler/irc" = "weechat";
          "text/plain" = "nvim";
        };
      };

      extraBinds = ''
        # To use '=' in a key sequence, substitute it with "Eq": "<Ctrl+Eq>"
        # If you wish to bind #, you can wrap the key sequence in quotes: "#" = quit

        <C-p> = :prev-tab<Enter>
        <C-n> = :next-tab<Enter>
        <C-t> = :term<Enter>
        ? = :help keys<Enter>
        <C-c> = :prompt 'Quit?' quit<Enter>
        <C-z> = :suspend<Enter>

        [messages]
        e = :next<Enter>
        <Down> = :next<Enter>
        <C-d> = :next 50%<Enter>
        <C-f> = :next 100%<Enter>
        <PgDn> = :next 100%<Enter>

        u = :prev<Enter>
        <Up> = :prev<Enter>
        <C-u> = :prev 50%<Enter>
        <C-b> = :prev 100%<Enter>
        g = :select 0<Enter>
        G = :select -1<Enter>

        E = :next-folder<Enter>
        <C-Down> = :next-folder<Enter>
        U = :prev-folder<Enter>
        <C-Up> = :prev-folder<Enter>
        C = :collapse-folder<Enter>
        <C-Left> = :collapse-folder<Enter>
        O = :expand-folder<Enter>
        <C-Right> = :expand-folder<Enter>

        v = :mark -t<Enter>
        <Space> = :mark -t<Enter>:next<Enter>
        V = :mark -v<Enter>

        T = :toggle-threads<Enter>
        zc = :fold<Enter>
        zo = :unfold<Enter>
        za = :fold -t<Enter>
        zM = :fold -a<Enter>
        zR = :unfold -a<Enter>
        <tab> = :fold -t<Enter>

        <Enter> = :view<Enter>
        d = :prompt 'Really delete this message?' 'delete-message'<Enter>
        D = :delete<Enter>
        a = :archive flat<Enter>
        A = :unmark -a<Enter>:mark -T<Enter>:archive flat<Enter>

        c = :compose<Enter>

        rr = :reply -a<Enter>
        rq = :reply -aq<Enter>
        Rr = :reply<Enter>
        Rq = :reply -q<Enter>

        $ = :term<space>
        ! = :term<space>
        | = :pipe<space>

        / = :search<space>
        \ = :filter<space>
        n = :next-result<Enter>
        N = :prev-result<Enter>
        <Esc> = :clear<Enter>

        s = :split<Enter>
        S = :vsplit<Enter>

        pl = :patch list<Enter>
        pa = :patch apply <Tab>
        pd = :patch drop <Tab>
        pb = :patch rebase<Enter>
        pt = :patch term<Enter>
        ps = :patch switch <Tab>

        [messages:folder=Drafts]
        <Enter> = :recall<Enter>

        [view]
        / = :toggle-key-passthrough<Enter>/
        q = :close<Enter>
        O = :open<Enter>
        o = :open<Enter>
        S = :save<space>
        | = :pipe<space>
        D = :delete<Enter>
        A = :archive flat<Enter>

        <C-l> = :open-link <space>

        f = :forward<Enter>
        rr = :reply -a<Enter>
        rq = :reply -aq<Enter>
        Rr = :reply<Enter>
        Rq = :reply -q<Enter>

        H = :toggle-headers<Enter>
        <C-u> = :prev-part<Enter>
        <C-Up> = :prev-part<Enter>
        <C-e> = :next-part<Enter>
        <C-Down> = :next-part<Enter>
        E = :next<Enter>
        <C-Right> = :next<Enter>
        U = :prev<Enter>
        <C-Left> = :prev<Enter>

        [view::passthrough]
        $noinherit = true
        $ex = <C-x>
        <Esc> = :toggle-key-passthrough<Enter>

        [compose]
        # Keybindings used when the embedded terminal is not selected in the compose view
        $noinherit = true
        $ex = <C-x>
        $complete = <C-o>
        <C-u> = :prev-field<Enter>
        <C-Up> = :prev-field<Enter>
        <C-e> = :next-field<Enter>
        <C-Down> = :next-field<Enter>
        <A-p> = :switch-account -p<Enter>
        <C-Left> = :switch-account -p<Enter>
        <A-n> = :switch-account -n<Enter>
        <C-Right> = :switch-account -n<Enter>
        <tab> = :next-field<Enter>
        <backtab> = :prev-field<Enter>
        <C-p> = :prev-tab<Enter>
        <C-n> = :next-tab<Enter>

        [compose::editor]
        # Keybindings used when the embedded terminal is selected in the compose view
        $noinherit = true
        $ex = <C-x>
        <C-u> = :prev-field<Enter>
        <C-Up> = :prev-field<Enter>
        <C-e> = :next-field<Enter>
        <C-Down> = :next-field<Enter>
        <C-p> = :prev-tab<Enter>
        <C-n> = :next-tab<Enter>

        [compose::review]
        # Keybindings used when reviewing a message to be sent
        y = :send<Enter>
        n = :abort<Enter>
        v = :preview<Enter>
        p = :postpone<Enter>
        q = :choose -o d discard abort -o p postpone postpone<Enter>
        e = :edit<Enter>
        a = :attach<space>
        d = :detach<space>

        [terminal]
        $noinherit = true
        $ex = <C-x>

        <C-p> = :prev-tab<Enter>
        <C-n> = :next-tab<Enter>
      '';
    };
  };



  accounts.email.accounts =   {
    mitdivGoogle = {
      primary = true;
      address = "mittaldivit@gmail.com";
      realName = "Divit Mittal";

      # authorization
      userName = "mittaldivit@gmail.com";
      passwordCommand = "bw get item 799962b2-43e6-4f6f-b455-ab30010c8ffe | jq -r '.fields | .[] | select(.name | startswith(\"App Password 1\")) | .value'";
      imap = {
        host = "imap.gmail.com";
        port = 993;
        tls.enable  = true;
      };
      smtp = {
        host = "smtp.gmail.com";
        port = 587;
        tls.enable = true;
      };

      # client sub-modules
      aerc.enable = true;
    };

    divibGoogle = {
      address = "divibmibbal@gmail.com";
      realName = "Divit Mittal";

      # authorization
      userName = "divibmibbal@gmail.com";
      passwordCommand = "bw get item 89f5c4b5-92b3-433c-a108-ab30010c8ffe | jq -r '.fields | .[] | select(.name | startswith(\"App Password 1\")) | .value'";
      imap = {
        host = "imap.gmail.com";
        port = 993;
        tls.enable  = true;
      };
      smtp = {
        host = "smtp.gmail.com";
        port = 587;
        tls.enable = true;
      };

      # client sub-modules
      aerc.enable = true;
    };

    finDivZoho = {
      address = "divitmittal@zohomail.in";
      realName = "Divit";

      # authorization
      userName = "divitmittal@zohomail.in";
      passwordCommand = "bw get item 6b225cba-0660-4a62-bcd1-ab30010c8ffe | jq -r '.fields | .[] | select(.name | startswith(\"App Password 1\")) | .value'";
      imap = {
        host = "imap.zoho.in";
        port = 993;
        tls.enable  = true;
      };
      smtp = {
        host = "smtp.zoho.in";
        port = 465;
        tls.enable = true;
      };

      # client sub-modules
      aerc.enable = true;
    };

    divApple = {
      address = "divitmittal@me.com";
      aliases = [ "divitmittal@icloud.com" ];
      realName = "Divit Mittal";

      # authorization
      userName = "divitmittal@me.com";
      passwordCommand = "bw get item 044b03fa-b488-414b-b8b0-ab30010c8ffe | jq -r '.fields | .[] | select(.name | startswith(\"App Password 1\")) | .value'";
      imap = {
        host = "imap.mail.me.com";
        port = 993;
        tls.enable  = true;
      };
      smtp = {
        host = "smtp.mail.me.com";
        port = 587;
        tls.enable = true;
      };

      # client sub-modules
      aerc.enable = true;
    };

    dpsDivGoogle = {
      address = "r21071divit@dpsrkp.net";
      realName = "Divit Mittal";

      # authorization
      userName = "r21071divit@dpsrkp.net";
      passwordCommand = "bw get item 350a1487-8bba-46cc-8170-ab30010c8ffe | jq -r '.fields | .[] | select(.name | startswith(\"App Password 1\")) | .value'";
      imap = {
        host = "imap.gmail.com";
        port = 993;
        tls.enable  = true;
      };
      smtp = {
        host = "smtp.gmail.com";
        port = 587;
        tls.enable = true;
      };

      # client sub-modules
      aerc.enable = true;
    };

    forDivGoogle = {
      address = "d.i.v.i.t.m.i.t.t.a.l.s@gmail.com";
      realName = "Divit Mittal";

      # authorization
      userName = "d.i.v.i.t.m.i.t.t.a.l.s@gmail.com";
      passwordCommand = "bw get item 9a690ec2-7179-4c79-b797-ac2b0117de05 | jq -r '.fields | .[] | select(.name | startswith(\"App Password 1\")) | .value'";
      imap = {
        host = "imap.gmail.com";
        port = 993;
        tls.enable  = true;
      };
      smtp = {
        host = "smtp.gmail.com";
        port = 587;
        tls.enable = true;
      };

      # client sub-modules
      aerc.enable = true;
    };

    devDivGoogle = {
      address = "64.69.76.69.74.m@gmail.com";
      realName = "Divit Mittal";

      # authorization
      userName = "64.69.76.69.74.m@gmail.com";
      passwordCommand = "bw get item 3bef8bc4-5c1f-4dff-8ed0-ae4500dd00d6 | jq -r '.fields | .[] | select(.name | startswith(\"App Password 1\")) | .value'";
      imap = {
        host = "imap.gmail.com";
        port = 993;
        tls.enable  = true;
      };
      smtp = {
        host = "smtp.gmail.com";
        port = 587;
        tls.enable = true;
      };

      # client sub-modules
      aerc.enable = true;
    };

    divOutlook = {
      address = "divitmittal@outlook.in";
      realName = "Divit Mittal";

      # authorization
      userName = "divitmittal@outlook.in";
      passwordCommand = "bw get item a22a772d-a4ce-4a5b-8a44-ab30010c8ffe | jq -r '.fields | .[] | select(.name | startswith(\"App Password 1\")) | .value'";
      imap = {
        host = "outlook.office365.com";
        port = 993;
        tls.enable  = true;
      };
      smtp = {
        host = "smtp-mail.outlook.com";
        port = 587;
        tls.enable = true;
      };

      # client sub-modules
      aerc.enable = true;
    };

    mujOutlook = {
      address = "divit.229309249@muj.manipal.edu";
      realName = "Divit Mittal";

      # authorization
      userName = "divit.229309249@muj.manipal.edu";
      passwordCommand = "${./mutt_oauth2.py} ${config.home.homeDirectory}/OS-nixCfg/secrets/email/refresh_token.gpg";
      imap = {
        host = "outlook.office365.com";
        port = 993;
        tls.enable  = true;
      };
      smtp = {
        host = "smtp-mail.outlook.com";
        port = 587;
        tls.enable = true;
      };

      # client sub-modules
      aerc = {
        enable = true;
        imapAuth = "xoauth2";
        smtpAuth = "xoauth2";
      };
    };
  };
}