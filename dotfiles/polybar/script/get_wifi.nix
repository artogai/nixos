{ pkgs }:
pkgs.writeShellScriptBin "get_wifi" ''
  echo wlp3s0
''
