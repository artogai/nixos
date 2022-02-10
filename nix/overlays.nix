{ nixpkgs, ... }:
let
  inherit (nixpkgs.lib) composeManyExtensions;
  inherit (builtins) attrNames readDir;
  localOverlays = map
    (fileName: import (./overlays + "/${fileName}"))
    (attrNames (readDir ./overlays));
in
composeManyExtensions localOverlays
