# /etc/nixos/flake.nix
{
  description = "nixos config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    my-secrets = {
      url = "git+ssh://git@github.com/andyrusiecki/nix-secrets?ref=main&shallow=1";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      # "andy-pc" = nixpkgs.lib.nixosSystem {
      #   system = "x86_64-linux";
      #   specialArgs = { inherit inputs self; };
      #   modules = [
      #     ./hosts/andy-pc/configuration.nix
      #     home-manager.nixosModules.home-manager
      #   ];
      # };
      # "andy-framework" = nixpkgs.lib.nixosSystem {
      #   system = "x86_64-linux";
      #   specialArgs = { inherit inputs self; };
      #   modules = [
      #     ./hosts/andy-framework/configuration.nix
      #     home-manager.nixosModules.home-manager
      #     nixos-hardware.nixosModules.framework-intel-core-ultra-series3
      #   ];
      # };
      "andy-vm" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs self; };
        modules = [
          ./hosts/andy-vm/configuration.nix
          home-manager.nixosModules.home-manager
        ];
      };
    };
  };
}
