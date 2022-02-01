{
  nix.gc = {
    automatic = true;
    dates = "12:00";
    options = "--delete-older-than 30d";
  };
}
