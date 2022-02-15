inp: hosts:

with inp;
with inp.nixpkgs;
with inp.nixpkgs.lib;
with builtins;

let
  makeHost =
    { host, home ? null, deploy ? false, system ? "x86_64-linux" }:
    let
      systemModules =
        [
          (import ../hosts/${
          host})
          sops-nix.nixosModules.sops
          {
            nixpkgs = {
              config.allowUnfree = true;
              overlays = [ (import ./overlays.nix nixpkgs) deploy-rs.overlay ];
            };
          }
        ];

      homeModules = lists.optionals (!isNull home)
        [
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${home} = import ../users/${home}/home.nix;
            };
          }
        ];

      modules = systemModules ++ homeModules;
    in
    {
      ${host} = {
        cfg = nixosSystem { inherit system modules; };

        deploy = mkIf deploy {
          hostName = host;
          profiles.system = {
            path = deploy-rs.lib.${system}.activate.nixos cfg;
            sshUser = "root";
          };
        };
      };
    };
in
  lists.foldr lib.mergeAttrs {} (map makeHost hosts)
