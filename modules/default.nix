{ config, pkgs, ... }:

{
  imports = [
    ./fonts.nix
    ./gnome.nix
    ./programs.nix
    ./secrets.nix
    ./services.nix
    ./system.nix
    ./users.nix
  ];
}
