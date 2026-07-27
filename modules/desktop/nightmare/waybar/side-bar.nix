let
  feature = "_nightmare-waybar";
in
{ inputs, self, ... }: {
  flake.modules.homeManager.${feature} = { pkgs, lib, ... }: {
    programs.waybar.settings = lib.mkAfter [
      {
        name = "side";
        layer = "top";
        position = "left";
        width = 72;
        spacing = 8;
        margin-top = 8;
        margin-bottom = 8;
        modules-left = [
        ];
        modules-center = [
          "wlr/taskbar"
        ];
        modules-right = [
        ];
        "wlr/taskbar" = {
          "format" = "{icon}";
          "icon-size" = 20;
          "tooltip-format" = "{title}";
          "on-click" = "activate";
        };
      }
    ];
  };
}
