{
  description = "Main configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = github:Mic92/sops-nix;
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, sops-nix, ... }:
    let
      makeOS = cfgPath:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            cfgPath
            sops-nix.nixosModules.sops
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.artem = import ./users/artem/home.nix;
              };
              nixpkgs = {
                config.allowUnfree = true;
                overlays = [ (import ./nix/overlays.nix nixpkgs) ];
              };
            }
          ];
        };
    in
    {
      nixosConfigurations = {

        laptop = makeOS ./machines/laptop/configuration.nix;

        pc = makeOS ./machines/pc/configuration.nix;

      };
    };
}
