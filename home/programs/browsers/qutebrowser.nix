# TODO: Split this up!
{
  programs.qutebrowser = {
    enable = true;

    settings = {
      # Key bindings
      bindings.commands.global.normal = {
        ",M" = "hint links spawn mpv {hint-url}";
        ",m" = "spawn mpv {url}";
      };

      # Colors
      colors.webpage = {
        darkmode.algorithm = "lightness-cielab";
        darkmode.enabled = false;
        darkmode.policy.images = "smart";
        preferred_color_scheme = "dark";
      };

      # Content settings
      content = {
        blocking.enabled = true;
        desktop_capture.global = true;
        desktop_capture."https://teams.microsoft.com" = true;

        geolocation."https://www.lieferando.de" = true;

        javascript.clipboard = {
          global = "access";
        };

        media = {
          audio_capture = {
            "https://app.zoom.us" = true;
            "https://chatgpt.com" = true;
            "https://discord.com" = true;
            "https://teams.microsoft.com" = true;
          };

          audio_video_capture."https://teams.microsoft.com" = true;
          video_capture = {
            "https://app.zoom.us" = true;
            "https://teams.microsoft.com" = true;
          };
        };

        notifications.enabled = {
          global = "ask";
          "https://app.zoom.us" = true;
          "https://de.lovense.com" = false;
          "https://teams.microsoft.com" = true;
          "https://thepiratebay.org" = false;
          "https://web.telegram.org" = true;
          "https://web.whatsapp.com" = true;
          "https://www.lieferando.de" = true;
          "https://www.netflix.com" = true;
          "https://www.youtube.com" = false;
        };

        register_protocol_handler = {
          "https://mail.google.com?extsrc=mailto&url=%25s" = true;
          "https://outlook.office.com?mailtouri=%25s" = true;
        };
      };

      # Fonts
      fonts.default_family = "CaskaydiaCove Nerd Font";

      # Hints
      hints.padding.global = {
        bottom = 3;
        left = 5;
        right = 5;
        top = 3;
      };

      # Scrolling
      scrolling.smooth = true;

      # Statusbar
      statusbar.padding.global = {
        bottom = 10;
        left = 15;
        right = 15;
        top = 10;
      };

      # Tabs
      tabs = {
        favicons.scale = 1.5;
        padding.global = {
          bottom = 10;
          left = 15;
          right = 15;
          top = 10;
        };
      };

      # URL
      url = {
        searchengines = {
          DEFAULT = "https://duckduckgo.com/?q={}";
          a = "https://wiki.archlinux.org/?search={}";
          gh = "https://github.com/search?q={}&type=repositories";
          go = "https://www.google.com/search?q={}";
          rd = "https://www.reddit.com/search/?q={}";
          wp = "https://wallhaven.cc/search?q={}&categories=110&purity=100&atleast=3440x1440&sorting=relevance&order=desc&ai_art_filter=1&page=3";
          wps = "https://www.wsupercars.com/?s={}&post_type%5B%5D=widewallpapers";
          yt = "https://www.youtube.com/results?search_query={}";
        };

        start_pages = ["https://startertab.com/"];
      };
    };
  };
}
