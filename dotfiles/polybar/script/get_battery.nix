{ pkgs }:
pkgs.writeShellScriptBin "get_battery" ''
  echo BAT0
''
