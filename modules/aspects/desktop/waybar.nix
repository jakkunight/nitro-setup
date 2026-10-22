let
  feature = "waybar";
in
{ inputs, lib, ... }:
{
  den.aspects.${feature}.homeManager =
    {
      config,
      pkgs,
      home,
      den,
      ...
    }:
    {
      home.packages = [ pkgs.nerd-fonts._0xproto ];

      programs = {
        waybar = {
          enable = true;
          # package = inputs.waybar-git.packages.${pkgs.stdenv.hostPlatform.system}.waybar;
          systemd.enable = true;
          style = lib.mkAfter ''
            * {
              font-family: "0xProto Nerd Font", monospace;
            }
          '';
        };
      };
    };

}
