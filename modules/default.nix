{ config, pkgs, ... }:

{
  imports = [
    ./fonts.nix
    ./gnome.nix
    ./programs.nix
    ./services.nix
    ./system.nix
    ./users.nix
  ];
}
