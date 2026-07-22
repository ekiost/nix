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

    xremap-flake.url = "github:xremap/nix-flake";
  };

  outputs =
    {
      self,
      nix-darwin,
      nixpkgs,
      home-manager,
      nix-homebrew,
      xremap-flake,
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
                ./modules/home
                ./modules/home/nixos.nix
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
