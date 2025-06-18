# Zellij config:
{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  programs.zellij = {
    enable = true;
    enableZshIntegration = false;
    settings = {
      theme = "tokyonight_night";
      themes = {
        tokyonight_night = {
          fg = "#c0caf5";
          bg = "#292e42";
          # Black should match the terminal background color
          # This ensures the top and bottom bars are transparent
          black = "#1a1b26";
          red = "#f7768e";
          green = "#9ece6a";
          yellow = "#e0af68";
          blue = "#7aa2f7";
          magenta = "#bb9af7";
          cyan = "#7dcfff";
          white = "#a9b1d6";
          orange = "#ff9e64";
        };
      };
      pane_frames = false;
      default_shell = "zsh";
    };
  };
  xdg.configFile."zellij/layouts/default.kdl".text = ''
    layout {
      default_tab_template {
        children
          pane size=2 borderless=true {
            plugin location="file:${inputs.zjstatus.packages."x86_64-linux".default}/bin/zjstatus.wasm" {
              format_left   "{mode} #[bold]{session}{tabs}"
              format_center ""
              format_right  "{command_git_branch} {datetime}"
              format_space  "|"

              border_enabled  "true"
              border_char     "─"
              border_format   "#[fg=#6C7086]{char}"
              border_position "top"

              hide_frame_for_single_pane "true"

              mode_normal  "#[bg=blue] "
              mode_tmux    "#[bg=#ffc387] "

              tab_normal   "#[fg=#6C7086] {name} "
              tab_active   "#[fg=#9399B2,bold,italic] {name} "

              command_git_branch_command     "git rev-parse --abbrev-ref HEAD"
              command_git_branch_format      "#[fg=blue] {stdout} "
              command_git_branch_interval    "10"
              command_git_branch_rendermode  "static"

              datetime        "#[fg=#6C7086,bold] {format} "
              datetime_format "%A, %d %b %Y %H:%M"
              datetime_timezone "America/Asuncion"
            }
          }
        }
    }'';
}
