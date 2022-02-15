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

  outputs = { self, nixpkgs, home-manager, sops-nix, deploy-rs } @ inp:
    with builtins;
    with nixpkgs.lib;
    rec {
      makeHosts = import ./nix/make-hosts.nix inp;

      hosts = makeHosts [
        { host = "pc"; home = "artem"; }
        { host = "laptop"; home = "artem"; }
        { host = "chekhov"; deploy = true; }
      ];

      nixosConfigurations = mapAttrs (h: desc: desc.cfg) hosts;
      deploy.nodes = mapAttrs (h: desc: desc.deploy) hosts;

      checks = mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
    };
}
