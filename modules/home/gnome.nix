# /etc/nixos/modules/home/gnome.nix
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    adw-gtk3
    gnome-tweaks
  ];

  gtk = {
    enable = true;
    colorScheme = "dark";
    #theme.package = pkgs.adw-gtk3;
  };

  programs.gnome-shell.extensions = [
    { package = pkgs.gnomeExtensions.app-hider; }
    { package = pkgs.gnomeExtensions.appindicator; }
    { package = pkgs.gnomeExtensions.background-logo; }
    { package = pkgs.gnomeExtensions.blur-my-shell; }
    { package = pkgs.gnomeExtensions.caffeine; }
    { package = pkgs.gnomeExtensions.dash-to-dock; }
    { package = pkgs.gnomeExtensions.in-picture; }
    { package = pkgs.gnomeExtensions.just-perfection; }
    { package = pkgs.gnomeExtensions.night-theme-switcher; }
    { package = pkgs.gnomeExtensions.rounded-window-corners-reborn; }
  ];
}
