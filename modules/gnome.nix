{ config, pkgs, ... }:

{
  services.desktopManager.gnome.enable = true;
  services.desktopManager.gnome.extraGSettingsOverrides = "";

  services.displayManager.gdm.enable = true;

  # TODO: ensure xdg is setup
}
