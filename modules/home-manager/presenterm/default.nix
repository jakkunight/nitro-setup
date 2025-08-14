{
  pkgs,
  lib,
  ...
}: let
  yamlFormat = pkgs.formats.yaml {};
  presentermConfigFile = "config.yaml";
  presentermConfig = {
    defaults = {
      theme = "terminal-dark";
    };
    transition = {
      duration_millis = 1000;
      frames = 60;
      animation = {
        style = "fade";
      };
    };
    # [WARN] Use this at YOUR OWN RISK!!!
    snippet = {
      exec = {
        enable = true;
      };
      exec_replace = {
        enable = true;
      };
    };
  };
in {
  home = {
    packages = with pkgs; [
      presenterm
      mermaid-cli
    ];
  };
  xdg.configFile."presenterm/${presentermConfigFile}" = {
    source = (yamlFormat.generate presentermConfigFile presentermConfig).overrideAttrs (
      # [NOTE] This was taken from home-manager/alacritty module for reference...
      finalAttrs: prevAttrs: {
        buildCommand = lib.concatStringsSep "\n" [
          prevAttrs.buildCommand
          # TODO: why is this needed? Is there a better way to retain escape sequences?
          "substituteInPlace $out --replace-quiet '\\\\' '\\'"
        ];
      }
    );
  };
}
