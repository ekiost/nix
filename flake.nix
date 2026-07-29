{
  description = "My Nix configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    nowplaying-cli-src = {
      url = "github:kirtan-shah/nowplaying-cli";
      flake = false;
    };

    xremap-flake.url = "github:xremap/nix-flake";

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs =
    {
      self,
      nix-darwin,
      nixpkgs,
      home-manager,
      nix-homebrew,
      nowplaying-cli-src,
      xremap-flake,
      plasma-manager,
      ...
    }:
    let
      darwinHostname = "Choon-Keats-MacBook-Air";
      nixosHostname = "Choon-Keats-NixOS";
      user = "ekiost";
    in
    {
      nixosConfigurations.${nixosHostname} = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit self user nixpkgs; };
        modules = [
          xremap-flake.nixosModules.default
          ./modules/nixos
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${user}.imports = [
                plasma-manager.homeModules.plasma-manager
                ./modules/home
                ./modules/home/nixos.nix
                ./modules/home/plasma.nix
              ];
            };
          }
        ];
      };

      darwinConfigurations.${darwinHostname} = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit self user nixpkgs; };
        modules = [
          ./modules/darwin
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit nowplaying-cli-src; };
              users.${user}.imports = [
                ./modules/home
                ./modules/home/darwin.nix
              ];
            };
          }
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              user = user;
            };
          }
        ];
      };
    };
}
