{
  nix = {
    settings.auto-optimise-store = true;

    gc = {
      automatic = true;
      dates = "04:00";
    };
  };
}
