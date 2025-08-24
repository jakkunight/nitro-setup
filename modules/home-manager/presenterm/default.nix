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
    options = {
      implicit_slide_ends = true;
      end_slide_shorthand = true;
      command_prefix = "presenterm:";
    };
    # transition = {
    #   duration_millis = 0;
    #   frames = 0;
    #   animation = {
    #     style = "";
    #   };
    # };
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
      python313Packages.weasyprint
      typst
      pandoc
      d2
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
