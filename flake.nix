{
  description = "";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware, ... }:
    let
      system = "x86_64-linux";

      mkHost = hostname: extraModules: nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/${hostname}/configuration.nix
          ./modules/common.nix
          ./modules/thinkpad.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.zxcv = import ./home;
          }
        ] ++ extraModules;
      };

    in {
      # NixOS machines
      nixosConfigurations = {
        rubidium  = mkHost "x250"  [ nixos-hardware.nixosModules.lenovo-thinkpad-x250 ];
        carbon = mkHost "t440p" [ nixos-hardware.nixosModules.lenovo-thinkpad-t440p ];
      };

      # home-manager for tungsten (fedora)
      homeConfigurations."zxcv" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [
          ./home
          {
            home.username = "zxcv";
            home.homeDirectory = "/home/zxcv";
          }
        ];
      };
    };
}