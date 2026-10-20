let
  feature = "heroic";
in
{ den, ... }:
{
  den.aspects.${feature} = {
    nixos =
      { pkgs, lib, ... }:
      {
        # Since Heroic uses a vulnerable version of PNPM:
        nixpkgs.config.permittedInsecurePackages = [
          "pnpm-10.29.2"
        ];
        environment.systemPackages = with pkgs; [
          heroic
          mangohud
          gamemode
          wine-wayland
          wine64
        ];
      };
    homeManager =
      { pkgs, lib, ... }:
      {
        programs.mangohud = {
          enable = true;
        };
        # Since Heroic uses a vulnerable version of PNPM:
        nixpkgs.config.permittedInsecurePackages = [
          "pnpm-10.29.2"
        ];
        home.packages = with pkgs; [
          heroic
          gamemode
          wine-wayland
          wine64
          _7zz
          cabextract
          zenity
        ];
      };
  };

}
