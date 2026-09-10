# /etc/nixos/hosts/andy-vm/configuration.nix
{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules
  ];

  # hostname
  networking.hostName = "andy-vm";

  # aggressive garbage collection to save space
  nix.gc.dates = lib.mkForce "daily";
  nix.gc.options = lib.mkForce "--delete-older-than 1d";

  # enable the SPICE guest webdav proxy daemon
  services.spice-webdavd.enable = true;

  # enable SPICE agent and QEMU guest agent for better VM integration (clipboard, resizing)
  services.spice-vdagentd.enable = true;
  services.qemuGuest.enable = true;

  systemd.user.services.spice-vdagent-client = {
    description = "spice-vdagent client";
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.spice-vdagent}/bin/spice-vdagent -x";
      Restart = "on-failure";
      RestartSec = "5";
    };
  };
  
  systemd.user.services.spice-vdagent-client.enable = lib.mkDefault true;
}
