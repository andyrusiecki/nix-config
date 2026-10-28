{
  description = "nixos config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    secrets = {
      url = "git+ssh://git@github.com/andyrusiecki/nix-secrets?ref=main&shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware, secrets, ... }@inputs:
    let
      commonModules = [
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.andy.imports = [ secrets.homeManagerModules.andy ];
        }
      ];

      mkHost = name: extraModules: nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs self; };
        modules = [ ./hosts/${name}/configuration.nix ] ++ commonModules ++ extraModules;
      };
    in {
      nixosConfigurations = {
        # "andy-pc" = mkHost "andy-pc" [ secrets.nixosModules.andy-pc ];
        # "andy-framework" = mkHost "andy-framework" [
        #   nixos-hardware.nixosModules.framework-intel-core-ultra-series3
        #   secrets.nixosModules.andy-framework
        # ];
        "andy-vm" = mkHost "andy-vm" [ secrets.nixosModules.andy-vm ];
      };
    };
}