{
  description = "Example nix-darwin system flake";

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

    mac-app-util.url = "github:hraban/mac-app-util";

    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/0.1";
  };

  outputs =
    {
      self,
      nix-darwin,
      nixpkgs,
      home-manager,
      mac-app-util,
      determinate,
    }:
    let
      hostname = "Choon-Keats-MacBook-Air";
      user = "choonkeatling";
    in
    {
      darwinConfigurations.${hostname} = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit self user; };
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
          determinate.darwinModules.default
        ];
      };
    };
}
