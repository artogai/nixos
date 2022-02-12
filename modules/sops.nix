{
  sops = {
    defaultSopsFile = ../secrets/default.yaml;
    age = {
      sshKeyPaths = [ "/home/artem/.ssh/id_ed25519" ];
      keyFile = "/home/artem/.config/sops/age/keys.txt";
      generateKey = true;
    };

    secrets = {
      "openvnp/home/auth-user-pass" = { };
      "openvnp/home/ca" = { };
      "openvnp/home/tls-auth" = { };
    };
  };
}
