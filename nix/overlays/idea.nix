self: super:
{
  jetbrains = {
    jdk = super.jdk;
    idea-community = super.jetbrains.idea-community.overrideAttrs (oldAttrs: rec {
      name = "idea-community-${version}";
      version = "2021.3.2";
      src = builtins.fetchurl {
        url = "https://download.jetbrains.com/idea/ideaIC-${version}.tar.gz";
        sha256 = "99e2225846d118e3190023abc65c8b2c62a1d1463f601c79a20b9494c54a08c9";
      };
    });
  };
}
