# /etc/nixos/modules/home/default.nix
{ config, pkgs, ... }:

{
  home.stateVersion = "26.05";
  programs.home-manager.enable = true;

  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
    "${config.home.homeDirectory}/go/bin"
    "${config.home.homeDirectory}/.cargo/bin"
  ];

  home.sessionVariables = {
    MESA_SHADER_CACHE_MAX_SIZE = "12G";
  };

  imports = [
    ./apps-gui.nix
    ./apps-tui.nix
    ./development.nix
    ./gnome.nix
    ./secrets.nix
    ./shells.nix
  ];
}
