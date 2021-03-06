nixpkgs:
let
  inherit (nixpkgs.lib) composeManyExtensions;
  inherit (builtins) attrNames readDir;
  overlays = map
    (fileName: import (./overlays + "/${fileName}"))
    (attrNames (readDir ./overlays));
in
composeManyExtensions overlays
