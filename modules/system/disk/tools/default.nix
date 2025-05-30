{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: {
  options = {
    disk.tools = {
      enable = lib.mkEnableOption "Enable disk management tools.";
    };
  };
  config = lib.mkIf config.disk.tools.enable {
    environment.systemPackages = [
      pkgs.gparted
      pkgs.parted
      pkgs.dust
      pkgs.ncdu
      pkgs.dua
      pkgs.exfatprogs
      pkgs.exfat
      pkgs.testdisk
      pkgs.ddrescue
      pkgs.burp
      pkgs.foremost
      pkgs.ntfs3g
      pkgs.memtester
      pkgs.rsync
      pkgs.sleuthkit
      pkgs.autopsy
      pkgs.chkrootkit
      pkgs.unhide
      pkgs.unhide-gui
      pkgs.safecopy
      pkgs.gptfdisk
    ];
  };
}
