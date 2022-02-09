{ pkgs }:
pkgs.writeShellScriptBin "get-backlight" ''
  ls -1 /sys/class/backlight/
''
