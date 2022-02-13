{
  description = "Main configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = github:Mic92/sops-nix;
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    deploy-rs.url = "github:serokell/deploy-rs";
    deploy-rs.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, sops-nix, deploy-rs, ... }:
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
              sops.secrets."passwords/home" = { };
            }
            {
              home-manager.users.artem.home.packages = [
                deploy-rs.defaultPackage.x86_64-linux
              ];
            }
          ];
        };
    in
    {
      nixosConfigurations = {
        laptop = makeOS ./machines/laptop/configuration.nix;

        pc = makeOS ./machines/pc/configuration.nix;

        chekhov = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./machines/chekhov/configuration.nix
            sops-nix.nixosModules.sops
            {
              nixpkgs = {
                config.allowUnfree = true;
                #overlays = [ (import ./nix/overlays.nix nixpkgs) ];
              };

              sops.defaultSopsFile = ./secrets/default.yaml;
              sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
              #sops.age.keyFile = "/var/lib/sops-nix/key.txt";
              #sops.age.generateKey = true;
              sops.gnupg.sshKeyPaths = [ ];
              sops.secrets."passwords/chekhov" = { };
            }
          ];
        };
      };

      deploy = {
        magicRollback = true;
        nodes = {
          chekhov = {
            hostname = "chekhov";
            profiles = {
              system = {
                path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.chekhov;
                user = "root";
                sshUser = "root";
              };
            };
          };
        };
      };

      checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
    };
}
