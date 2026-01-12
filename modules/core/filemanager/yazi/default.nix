{
  inputs,
  lib,
  config,
  ...
}: {
  flake.modules.nixos."filemanager/yazi" = {pkgs, ...}: {
    programs.yazi = {
      enable = true;
      package = pkgs.yazi;
      plugins = {
        inherit (pkgs.yaziPlugins) git sudo glow rsync gitui chmod dupes restore projects compress mount mediainfo toggle-pane smart-paste wl-clipboard full-border;
      };
      settings = {
        keymap = {
          mgr.prepend_keymap = [
            {
              run = "plugin mount";
              on = "M";
            }
          ];
        };
      };
    };
  };
  flake.modules.homeManager."filemanager/yazi" = {pkgs, ...}: {
    programs.yazi = {
      enable = true;
      package = pkgs.yazi;
      plugins = {
        inherit (pkgs.yaziPlugins) git sudo glow rsync gitui chmod dupes restore projects compress mount mediainfo toggle-pane smart-paste wl-clipboard full-border;
      };
      keymap = {
        mgr.prepend_keymap = [
          {
            run = "plugin mount";
            on = "M";
          }
        ];
      };
    };
  };
}
