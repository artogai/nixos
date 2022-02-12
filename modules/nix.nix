{ pkgs, ... }:
{
  nix = {
    settings.auto-optimise-store = true;

    gc = {
      automatic = true;
      dates = "12:00";
      options = "--delete-older-than 7d";
    };

    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
