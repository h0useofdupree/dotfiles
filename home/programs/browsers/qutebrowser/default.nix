{
  home.file.".config/qutebrowser/catppuccin/setup.py".source = ./catppuccin/setup.py;
  home.file.".config/qutebrowser/catppuccin/__init__.py".source = ./catppuccin/__init__.py;

  programs.qutebrowser = {
    enable = false;
    loadAutoconfig = true;
    enableDefaultBindings = true;

    settings = {
    };

    extraConfig =
      /*
      python
      */
      ''
        import catppuccin
        catppuccin.setup(c, 'mocha')

        c.tabs.padding = {'top': 10, 'bottom': 10, 'left': 15, 'right': 15}
        c.hints.padding = {'top': 3, 'bottom': 3, 'left': 5, 'right': 5}
        c.scrolling.smooth = True
        c.statusbar.padding = {'top': 10, 'bottom': 10, 'left': 15, 'right': 15}
        c.tabs.favicons.scale = 1.5
      '';

    searchEngines = {
      DEFAULT = "https://duckduckgo.com/?q={}";
      a = "https://wiki.archlinux.org/?search={}";
      gh = "https://github.com/search?q={}&type=repositories";
      go = "https://www.google.com/search?q={}";
      nw = "https://wiki.nixos.org/index.php?search={}";
      rd = "https://www.reddit.com/search/?q={}";
      yt = "https://www.youtube.com/results?search_query={}";
    };

    quickmarks = {
      yt = "https://www.youtube.com/";
      gh = "https://github.com/";
      wa = "https://web.whatsapp.com/";
      mail1 = "https://mail.google.com/mail/u/1/#inbox";
      mail0 = "https://mail.google.com/mail/u/0/#inbox";
      gpt = "https://chat.openai.com/?model=text-davinci-002-render-sha";
      todo = "https://todoist.com/app/upcoming";
      fhdw = "https://my.fhdw.de/timetable_31.php";
      rd = "https://www.reddit.com/";
      mail2 = "https://outlook.office.com/mail/";
      netflix = "https://www.netflix.com/browse";
      teams = "https://teams.microsoft.com/_#/conversations/General?threadId=19:268092bad96a496799f6cd6815cde066@thread.tacv2&ctx=channel";
      pdf = "https://simplepdf.eu/";
      ascii = "http://www.patorjk.com/software/taag/";
      mbp = "https://www.movieboxpro.app/";
      hyprwiki = "https://wiki.hyprland.org/";
      avd = "https://client.wvd.microsoft.com/arm/webclient/index.html";
      lab = "http://localhost:8888/lab";
      discord = "https://discord.com/channels/@me";
      edgar = "https://wiki.edgar.de/#all-updates";
      jira = "https://ticket.edgar.de/secure/Dashboard.jspa";
      rdp = "https://client.wvd.microsoft.com/arm/webclient/index.html";
      citrix = "https://citrix.infoscreen.de/vpn/index.html";
      nagios = "https://check.infoscreen.de/pv/thruk/cgi-bin/main.cgi";
      aws = "https://aws.amazon.com/console/";
      vis = "https://www.kaleidosync.com/spotify?access=BQCNLUukrCxHkDx8NKjA2KhV7qM3__X9X_Q4vdFdc8r3M60dbZPeoweOzkkLkLFlgb7l8zuNmm-mCOd5VUsmj_VK0qB8eyAj9h_DfglkqY2I1Tp_GHDx1uJWOBQeNvpj_kqn7TZuXz6cHg38alwFaO2XP9--KHpg8D7VSt6A6RqyX3-Qz6FmpYFkUWn70R1700Ze-y5LVgSlkE8vhJ0G&refresh=AQBKe3hmhYviFCpmcAaXCaJwWdJbvnXKRxfRZXHifOCQ_NY06bL0YGi6vz9P9vwUBmYnqacPZsyFurRI-q_Dxs9Aw4QoJFkdpO9tMUbr9eJuXIb62-yXZiz7q_gtLUypWM4";
      wiz = "https://app.wiz.io/";
      disney = "https://www.disneyplus.com/de-de/home";
      drive = "https://drive.google.com/drive/u/0/home";
    };

    # greasemonkey = [
    #   (pkgs.fetchurl {
    #     url = "https://raw.githubusercontent.com/afreakk/greasemonkeyscripts/4cb4b6dfcb31545f88b2fcae87f5fde33157fd72/youtube_sponsorblock.js";
    #     sha256 = "sha256-1ccqg60m4if1gdhq92v50sfpwz81l2a3r55iwjqgy738xmsml0wz";
    #   })
    #   (pkgs.writeText "some-script.js" ''
    #     // ==UserScript==
    #     // @name  Some Greasemonkey script
    #     // ==/UserScript==
    #   '')
    # ];
  };
}
