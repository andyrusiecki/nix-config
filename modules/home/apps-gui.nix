# /etc/nixos/modules/home/apps.nix
{ lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    _1password-gui
    _1password-cli
    google-chrome
    hunspell # libreoffice spellcheck
    hunspellDicts.en_US # libreoffice spellcheck
    libreoffice-fresh
    nextcloud-client
    pika-backup
    pods
    postman
    protonplus
    signal-desktop
    spotify
  ];

  programs.discord.enable = true;

  programs.firefox = {
    enable = true;

    languagePacks = [ "en-US" ];

    policies = {
      DontCheckDefaultBrowser       = true;
      HardwareAcceleration          = true;
      OfferToSaveLogins             = false;

      # Extensions
      # ExtensionSettings = let
      #   moz = short: "https://addons.mozilla.org/firefox/downloads/latest/${short}/latest.xpi";
      # in {
      #   "*".installation_mode = "blocked";

      #   "uBlock0@raymondhill.net" = {
      #     install_url       = moz "ublock-origin";
      #     installation_mode = "force_installed";
      #     updates_disabled  = true;
      #   };

      #   "{f3b4b962-34b4-4935-9eee-45b0bce58279}" = {
      #     install_url       = moz "animated-purple-moon-lake";
      #     installation_mode = "force_installed";
      #     updates_disabled  = true;
      #   };

      #   "{73a6fe31-595d-460b-a920-fcc0f8843232}" = {
      #     install_url       = moz "noscript";
      #     installation_mode = "force_installed";
      #     updates_disabled  = true;
      #   };
      # };

      # # Extension configuration
      # "3rdparty".Extensions = {
      #   "uBlock0@raymondhill.net".adminSettings = {
      #     userSettings = rec {
      #       uiTheme            = "dark";
      #       uiAccentCustom     = true;
      #       uiAccentCustom0    = "#8300ff";
      #       cloudStorageEnabled = mkForce false;

      #       importedLists = [
      #         "https://filters.adtidy.org/extension/ublock/filters/3.txt"
      #         "https://github.com/DandelionSprout/adfilt/raw/master/LegitimateURLShortener.txt"
      #       ];

      #       externalLists = lib.concatStringsSep "\n" importedLists;
      #     };

      #     selectedFilterLists = [
      #       "CZE-0"
      #       "adguard-generic"
      #       "adguard-annoyance"
      #       "adguard-social"
      #       "adguard-spyware-url"
      #       "easylist"
      #       "easyprivacy"
      #       "https://github.com/DandelionSprout/adfilt/raw/master/LegitimateURLShortener.txt"
      #       "plowe-0"
      #       "ublock-abuse"
      #       "ublock-badware"
      #       "ublock-filters"
      #       "ublock-privacy"
      #       "ublock-quick-fixes"
      #       "ublock-unbreak"
      #       "urlhaus-1"
      #     ];
      #   };
      # };
    };

    profiles.default.search = {
      force           = true;
      default         = "ddg";
      privateDefault  = "ddg";

      engines = {
        "Nix Packages" = {
          urls = [
            {
              template = "https://search.nixos.org/packages";
              params = [
                { name = "channel"; value = "unstable"; }
                { name = "query";   value = "{searchTerms}"; }
              ];
            }
          ];
          icon           = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@np" ];
        };

        "Nix Options" = {
          urls = [
            {
              template = "https://search.nixos.org/options";
              params = [
                { name = "channel"; value = "unstable"; }
                { name = "query";   value = "{searchTerms}"; }
              ];
            }
          ];
          icon           = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@no" ];
        };

        "NixOS Wiki" = {
          urls = [
            {
              template = "https://wiki.nixos.org/w/index.php";
              params = [
                { name = "search"; value = "{searchTerms}"; }
              ];
            }
          ];
          icon           = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@nw" ];
        };
      };
    };
  };

  programs.ghostty = {
    enable = true;

    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;

    installBatSyntax = true;
    installVimSyntax = true;

    settings = {
      font-family = "AdwaitaMono Nerd Font";
      font-size = 10;
    };
  };

  services.ludusavi = {
    enable = true;
  };

  programs.mangohud = {
    enable = true;
    enableSessionWide = true;

    settings = {
      fps_limit = 235;
      vsync = 1;
      gl_vsync = 0;

      gpu_stats = true;
      gpu_temp = true;
      cpu_stats = true;
      cpu_temp = true;
      ram = true;
      vram = true;
      fps = true;
      frame_timing_detailed = true;
      vulkan_driver = true;
      wine = true;
      winesync = true;
      present_mode = true;

      font_size = 32;
      text_outline = true;
      no_display = true;

      toggle_hud = "Shift_R+F5";
      toggle_preset = "Shift_R+F4";
      toggle_fps_limit = "Shift_R+F3";
    };
  };

  programs.obs-studio.enable = true;

  programs.obsidian = {
    enable = true;
    cli.enable = true;
  };

  programs.prismlauncher.enable = true;
  programs.vscode.enable = true;

  # TODO: move into apps or scripts section
  home.activation.fixSteamIcons = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    for f in ~/.local/share/applications/*.desktop; do
      id=$(grep -Eo 'steam://rungameid/[0-9]+' "$f" | sed 's#.*/##') || true
      [ -n "$id" ] || continue
      last=$(tail -n1 "$f" || true)
      want="StartupWMClass=steam_app_$id"
      [ "$last" = "$want" ] || echo "$want" >> "$f"
    done
  '';
}
