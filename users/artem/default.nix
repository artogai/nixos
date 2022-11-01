{
  users = {
    users.artem = {
      uid = 1000;
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIt5U3CZ+7d/hPDyUhyEnQxRk8iLJoLosuUj3jvWVRVH"
      ];
    };
  };
}
