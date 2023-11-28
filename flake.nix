{
  description = "Main configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.05";

    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = github:Mic92/sops-nix;
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    deploy-rs.url = "github:serokell/deploy-rs";
    deploy-rs.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, sops-nix, deploy-rs } @ inp:
    with builtins;
    with nixpkgs.lib;
    let
      makeHosts = import ./nix/make-hosts.nix inp;

      hosts = makeHosts [
        { host = "pc"; home = "artem"; }
        { host = "laptop"; home = "artem"; }
        { host = "workvm"; home = "vmuser"; }
        { host = "chekhov"; deploy = true; }
      ];
    in
    {
      nixosConfigurations = mapAttrs (h: desc: desc.cfg) hosts;
      deploy.nodes = mapAttrs (h: desc: desc.deploy) (filterAttrs (h: desc: hasAttr "hostname" desc.deploy) hosts);
      checks = mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
    };
}
