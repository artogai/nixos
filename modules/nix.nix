{ pkgs, ... }:
{
  nix = {
    settings.auto-optimise-store = true;

    gc = {
      automatic = true;
      dates = "12:00";
      options = "--delete-older-than 30d";
    };

    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
