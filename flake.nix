{
  description = "My Macbook Air configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs = inputs@{ nixpkgs, nix-darwin, home-manager, nix-homebrew, mac-app-util, ... }:
    let
      user = "choonkeatling";
      hostname = "Choon-Keats-MacBook-Air";
    in
    {
      darwinConfigurations.${hostname} = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit user; };
        modules = [
          ./modules/darwin
          mac-app-util.darwinModules.default
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${user}.imports = [
                ./modules/home-manager
                mac-app-util.homeManagerModules.default
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
