{

  description = "My first flake";

  inputs = {
    #nixpkgs = {
    #  url = "github:NixOS/nixpkgs/nixos-23.11"
    #};
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11"
    nixpkgs.url = "nixpkgs/nixos-23.11";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      lib = nixpkgs.lib;
      systemSettings = {
        system = "x86_64-linux"; # system arch
        hostname = "nixos-test"; # hostname
        profile = "personal"; # select a profile defined from my profiles directory
        timezone = "America/New_York"; # select timezone
        locale = "en_US.UTF-8"; # select locale
      };
      pkgs = nixpkgs.legacyPackages.${systemSettings.system};
      userSettings = {
        username = "ryankey";
        name = "Reece";
        email = "reeceyankey@gmail.com";
      };
    in {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          system = systemSettings.system;
          modules = [ ./configuration.nix ];
          specialArgs = {
            inherit systemSettings;
            inherit userSettings;
          };
        };
      };
      homeConfigurations = {
        ${userSettings.username} = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home.nix ];
          extraSpecialArgs = {
            inherit systemSettings;
            inherit userSettings;
          };
        };
      };
    };

}
