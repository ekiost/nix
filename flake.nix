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

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
  };

  outputs =
    {
      self,
      nix-darwin,
      nixpkgs,
      home-manager,
      nix-homebrew,
      xremap-flake,
      plasma-manager,
      nixos-wsl,
      ...
    }:
    let
      darwinHostname = "Choon-Keats-MacBook-Air";
      nixosHostname = "Choon-Keats-NixOS";
      wslHostname = "nixos";
      user = "ekiost";
    in
    {
      nixosConfigurations.${nixosHostname} = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit self user nixpkgs; };
        modules = [
          xremap-flake.nixosModules.default
          ./hosts/nixos
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${user}.imports = [
                plasma-manager.homeModules.plasma-manager
                ./home
                ./home/nixos
              ];
            };
          }
        ];
      };

      nixosConfigurations.${wslHostname} = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit self user nixpkgs; };
        system = "x86_64-linux";
        modules = [
          nixos-wsl.nixosModules.default
          ./hosts/wsl
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${user}.imports = [
                ./home
                ./home/wsl
              ];
            };
          }
        ];
      };

      darwinConfigurations.${darwinHostname} = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit self user nixpkgs; };
        modules = [
          ./hosts/darwin
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${user}.imports = [
                ./home
                ./home/darwin
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
