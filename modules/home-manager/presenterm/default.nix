{pkgs, ...}: let
  yamlFormat = pkgs.formats.yaml;
  presentermConfigFile = "config.yaml";
  presentermConfig = {
    theme = "terminal-dark";
    transition = {
      duration_millis = 1000;
      frames = 60;
      animation = {
        style = "fade";
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
  };
in {
  home = {
    packages = with pkgs; [
      presenterm
      mermaid-cli
    ];
    xdg.configFile."presenterm/${presentermConfigFile}" = {
      source = yamlFormat.generate presentermConfigFile presentermConfig;
    };
  };
}
