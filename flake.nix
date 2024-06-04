{

  description = "My first flake";

  inputs = {
    #nixpkgs = {
    #  url = "github:NixOS/nixpkgs/nixos-23.11"
    #};
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11"
    nixpkgs.url = "nixpkgs/nixos-23.11";
    #home-manager.url = "github:nix-community/home-manager/release-23.11"
  };

  outputs = { self, nixpkgs, ... }:
    let
      lib = nixpkgs.lib;
      systemSettings = {
        username = "ryankey"; 
        system = "x86_64-linux"; # system arch
        hostname = "nixos-test"; # hostname
        profile = "personal"; # select a profile defined from my profiles directory
        timezone = "America/New_York"; # select timezone
        locale = "en_US.UTF-8"; # select locale
      };
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
      #nixosConfigurations = {
      #  nixos = lib.nixosSystem {
      #    system = "x86_64-linux";
      #    modules = [ ./configuration.nix ];
      #    specialArgs = {
      #      inherit systemSettings;
      #      inherit userSettings;
      #    };
      #  };
      #};
    };

}
