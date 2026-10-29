# /etc/nixos/modules/users.nix
{ config, pkgs, inputs, ... }:

{
  users.users."andy" = {
    isNormalUser = true;
    description = "Andy Rusiecki";
    extraGroups = [
      "networkmanager"
      "podman"
      "wheel"
    ];
    shell = pkgs.fish;
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    users.andy = {
      imports = [
        ./home
      ];
    };
  };
}
