# /etc/nixos/modules/home/gnome.nix
{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    adw-gtk3
    gnome-tweaks
    gnomeExtensions.app-hider
    gnomeExtensions.appindicator
    gnomeExtensions.background-logo
    gnomeExtensions.blur-my-shell
    gnomeExtensions.caffeine
    gnomeExtensions.dash-to-dock
    gnomeExtensions.in-picture
    gnomeExtensions.just-perfection
    gnomeExtensions.night-theme-switcher
    gnomeExtensions.rounded-window-corners-reborn
  ];

  gtk = {
    enable = true;
    colorScheme = "dark";
    #theme.package = pkgs.adw-gtk3;
  };

  dconf.enable = true;
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      clock-show-weekday = true;
      color-scheme = "prefer-dark";
      font-antialiasing = "rgba";
      gtk-theme = "adw-gtk3";
    };

    "org/gnome/desktop/peripherals/mouse".accel-profile = "flat";

    "org/gnome/desktop/peripherals/touchpad".two-finger-scrolling-enabled = true;

    "org/gnome/desktop/screensaver".lock-delay = lib.gvariant.mkUint32 1800;

    "org/gnome/desktop/session".idle-delay = lib.gvariant.mkUint32 900;

    "org/gnome/evolution-data-server/calendar".notify-enable-audio = false;

    "org.gnome.mutter".experimental-features = [ "scale-monitor-framebuffer" ];

    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-temperature = lib.gvariant.mkUint32 3700;
    };

    "org/gnome/shell" = {
      favorite-apps = [
        "org.gnome.Nautilus.desktop"
        "org.mozilla.firefox.desktop"
        "google-chrome.desktop"
        "com.slack.Slack.desktop"
        "com.spotify.Client.desktop"
        "discord.desktop"
        "org.signal.Signal.desktop"
        "steam.desktop"
        "com.microsoft.VSCode.desktop"
        "md.obsidian.Obsidian.desktop"
        "com.mitchellh.ghostty.desktop"
      ];

      enabled-extensions = [
        pkgs.gnomeExtensions.appindicator.extensionUuid
        pkgs.gnomeExtensions.background-logo.extensionUuid
        pkgs.gnomeExtensions.blur-my-shell.extensionUuid
        pkgs.gnomeExtensions.caffeine.extensionUuid
        pkgs.gnomeExtensions.in-picture.extensionUuid
        pkgs.gnomeExtensions.just-perfection.extensionUuid
        pkgs.gnomeExtensions.night-theme-switcher.extensionUuid
      ];
    };

    "org/gnome/system/location".enabled = true;

    # Extensions
    "org/gnome/shell/extensions/appindicator".custom-icons = [
      lib.gvariant.mkTuple [
        "Granola_status_icon_1"
        "/opt/granola/resources/icons/win-tray.ico"
        ""
      ]
    ];

    "org/gnome/shell/extensions/caffeine".nightlight-control = "always";

    "org/gnome/shell/extensions/in-picture" = {
      hide = true;
      stick = true;
    };

    "org/gnome/shell/extensions/just-perfection" = {
      notification-banner-position = 2;
      support-notifier-type = 0;
    };

    "org/gnome/shell/extensions/weather".automatic-location = true;
  };
}
