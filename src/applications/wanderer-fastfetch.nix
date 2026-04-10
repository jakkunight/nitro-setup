let
  feature = "wanderer-fastfetch";
in
{ self, ... }:
{
  flake.modules = {
    homeManager.${feature} =
      { pkgs, ... }:
      {
        imports = with self.modules.homeManager; [
          fastfetch
        ];
        programs.fastfetch = {
          settings = {
            logo = {
              source = "${
                self.packages.${pkgs.stdenv.hostPlatform.system}.wanderer-wallpapers
              }/share/sprites/wanderer-sprite.png";
              type = "auto";
              # preserveAspectRatio = true;
              width = 48;
            };
            modules = [
              "title"
              "separator"
              "os"
              "host"
              {
                "type" = "kernel";
                "format" = "{release}";
              }
              "uptime"
              {
                "type" = "packages";
                "combined" = true;
              }
              "shell"
              {
                "type" = "display";
                "compactType" = "original";
                "key" = "Resolution";
              }
              "de"
              "wm"
              "wmtheme"
              "theme"
              "icons"
              "terminal"
              {
                "type" = "terminalfont";
                "format" = "{/name}{-}{/}{name}{?size} {size}{?}";
              }
              "cpu"
              {
                "type" = "gpu";
                "key" = "GPU";
                "format" = "{name}";
              }
              {
                "type" = "memory";
                "format" = "{used} / {total}";
              }
              "break"
              "colors"
            ];
          };
        };
      };
  };
}
