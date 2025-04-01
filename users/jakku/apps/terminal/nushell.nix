{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  programs.nushell = {
    enable = true;
    configFile = {
      text = ''
        $env.config = {
          show_banner: true,
          buffer_editor: nvim,
        }
      '';
    };
  };
}
