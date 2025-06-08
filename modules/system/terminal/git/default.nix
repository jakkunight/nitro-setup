{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = [
    pkgs.git
    pkgs.gitui
  ];
}
