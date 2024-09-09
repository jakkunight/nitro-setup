{ pkgs, config, lib, ... }@inputs:
{
  home.packages = [
    # Android SDK:
    pkgs.android-tools
    # ADB utilities:
    pkgs.adbtuifm
    pkgs.adbfs-rootless
  ];
}
