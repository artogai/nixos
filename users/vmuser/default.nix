{
  users = {
    users.vmuser = {
      uid = 1001;
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      initialPassword = "secret";
    };
  };
}
