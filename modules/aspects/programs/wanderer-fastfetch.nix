let
  feature = "wanderer-fastfetch";
in
{ self, den, ... }:
{
  den.aspects.${feature}.homeManager =
    { pkgs, ... }:
    {
      imports =
        with den.aspects;
        map
          (
            a:
            if builtins.isAttrs a && a ? homeManager then
              (
                let
                  v = a.homeManager;
                in
                if builtins.isAttrs v && v ? __contentValues then
                  { imports = map (d: d.value) v.__contentValues; }
                else
                  v
              )
            else if builtins.isAttrs a && a ? provides then
              { }
            else
              a
          )
          [
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

}
