# /etc/nixos/hosts/andy-pc/configuration.nix
{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules
  ];

  # hostname
  networking.hostName = "andy-pc";

  # hardware - keyboards and mice
  hardware.wooting.enable = true;
}
