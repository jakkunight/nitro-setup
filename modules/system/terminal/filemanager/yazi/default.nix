{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  options = {
    modules.system.terminal.filemanager.yazi.enable = lib.mkEnableOption "Enable Yazi.";
  };
  config = lib.mkIf config.modules.system.terminal.filemanager.yazi.enable {
    environment.systemPackages = [
      pkgs.ffmpeg
      pkgs.file
      pkgs._7zz
      pkgs.jq
      pkgs.poppler
      pkgs.fd
      pkgs.rg
      pkgs.fzf
      pkgs.zoxide
      pkgs.resvg
      pkgs.imagemagick
      pkgs.xclip
      pkgs.xsel
      pkgs.xl-clipboard
      inputs.yazi.packages.${pkgs.system}.yazi
    ];
  };
}
