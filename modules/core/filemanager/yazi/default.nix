{
  inputs,
  lib,
  config,
  ...
}: {
  flake.modules.nixos."filemanager/yazi" = {pkgs, ...}: {
    programs.yazi = {
      enable = true;
      plugins = {
        inherit (pkgs.yaziPlugins) git sudo glow rsync gitui chmod dupes restore projects compress mediainfo toggle-pane smart-paste wl-clipboard full-border;
      };
    };
  };
}
