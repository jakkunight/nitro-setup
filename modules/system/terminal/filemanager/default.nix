{
  config,
  lib,
  ...
}: {
  imports = [
    ./yazi
  ];
  modules.system.terminal.filemanager.yazi.enable = lib.mkDefault true;
}
