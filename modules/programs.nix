{ config, pkgs, ... }:

{
  imports = [
    ./fonts.nix
  ];

  # Shells
  programs.bash.enable = true;
  programs.fish.enable = true;
  programs.zsh.enable = true;

  # 1Password
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    # Certain features, including CLI integration and system authentication support,
    # require enabling PolKit integration on some desktop environments (e.g. Plasma).
    polkitPolicyOwners = [ "andy" ];
  };

  # Gaming
  programs.gamemode.enable = true;

  programs.steam = {
    enable = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    remotePlay.openFirewall = true;

    gamescopeSession.enable = true;
    extraCompatPackages = [
      #pkgs.proton-cachyos (does not exist)
      pkgs.proton-ge-bin
    ];
  };

  # Productivity
  programs.zoom-us.enable = true;

  # Virtualization
  programs.virt-manager.enable = true;

  virtualisation.containers.registries.search = [ "docker.io" ];
  virtualisation.podman = {
    enable = true;

    autoPrune.enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
    defaultNetwork.settings.dns_enabled = true;
  };
}
