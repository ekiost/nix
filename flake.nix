{
  description = "My Macbook Air configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };


  outputs =
    inputs@{ self
    , nix-darwin
    , nixpkgs
    , nix-homebrew
    , home-manager
    }:
    let
      user = "choonkeatling";
      hostname = "Choon-Keats-MacBook-Air";
    in
    {
      darwinConfigurations.${hostname} = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit self user; };
        modules = [
          ./modules/darwin
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew =
              {
                # Install Homebrew under the default prefix
                enable = true;

                # User owning the Homebrew prefix
                user = user;

              };
          }
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              verbose = true;
              users."${user}" = ./modules/home-manager;
            };
          }
        ];
      };
    };
}
