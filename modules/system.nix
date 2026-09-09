{ config, pkgs, self, ... }:

{
  # Bootloader - systemd-boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Bootloader - Plymouth
  boot.plymouth.enable = true;
  boot.kernelParams = [
    "quiet"
    "splash"
  ];

  # Kernel version
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Firmware
  hardware.enableAllFirmware = true;

  # Bluetooth
  hardware.bluetooth.enable = true;

  # Time Zone
  time.timeZone = "America/New_York";

  # Locale
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Networking - WiFi
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Networking - Proxy
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Networking - Network Manager
  networking.networkmanager.enable = true;

  # Firewall
  services.firewalld.enable = true;
  networking.nftables.enable = true;

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # NixOS
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  # Enable flakes and the new nix command-line interface
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "26.05";

  system.configurationRevision =
    if (self ? rev)
    then self.rev
    else "testing";

  system.autoUpgrade = {
    enable = true;
    operation = "boot";
    dates = "daily";
    flake = "github:andyrusiecki/nix-config";
    flags = [
      "--no-write-lock-file"
      "--update-input"
      "nixpkgs"
    ];
  };
}
