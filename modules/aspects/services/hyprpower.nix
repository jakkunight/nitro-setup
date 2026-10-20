let
  script = "hyprpower";
in
{
  perSystem =
    { pkgs, ... }:
    {
      packages.${script} = pkgs.writeShellApplication {
        name = script;
        runtimeInputs = [ ];
        bashOptions = [
          "nullglob"
        ];
        text = ''
          # This is a script to turn off all the Hyprland decorations
          # for max performance mode.
        '';
      };
    };
}
