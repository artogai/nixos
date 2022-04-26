self: super:
{
  jetbrains = {
    jdk = super.jdk11;
    idea-community = super.jetbrains.idea-community.overrideAttrs (oldAttrs: rec {
      name = "idea-community-${version}";
      version = "2022.1";
      src = builtins.fetchurl {
        url = "https://download.jetbrains.com/idea/ideaIC-${version}.tar.gz";
        sha256 = "0400e6152fa0173e4e9a514c6398eef8f19150893298658c0b3eb1427e5bcbe5";
      };
    });
  };
}
