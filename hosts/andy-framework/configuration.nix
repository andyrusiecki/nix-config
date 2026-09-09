# /etc/nixos/hosts/andy-framework/configuration.nix
{ config, pkgs, ... }:

{
  imports =
    [
      #./hardware-configuration.nix
      ../../modules
    ];

  # hostname
  networking.hostName = "andy-framework";

  # hardware - intel cpu
  # hardware.cpu.intel.npu.enable = true;

  # hardware.graphics.extraPackages = [
  #   pkgs.intel-media-driver
  # ];

  # hardware - light sensor
  # hardware.sensor.iio.enable = true;
}
