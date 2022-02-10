{
  description = "Main configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inp @ { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      overlays = import ./nix/overlays.nix inp;
    in
    {
      nixosConfigurations = {
        laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./machines/laptop/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.artem = import ./users/artem/home.nix;
              };
              nixpkgs.overlays = [ overlays ];
            }
          ];
          specialArgs = { inherit inp; };
        };
      };
    };
}
