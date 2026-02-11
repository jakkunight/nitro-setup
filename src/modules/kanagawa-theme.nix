let
  moduleName = "kanagawa-theme";
in
  {
    inputs,
    self,
    withSystem,
    ...
  }: {
    flake.nixosModules.${moduleName} = {
      pkgs,
      lib,
      ...
    }: {
      imports = [
        inputs.stylix.nixosModules.stylix
      ];
      stylix = {
        enable = true;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";
        image = "${withSystem pkgs.stdenv.hostPlatform.system self.packages.wallpapers}/share/wallpapers/wanderer-sakura-wallpaper.jpg";
      };
    };
    flake.homeModules.${moduleName} = {
      pkgs,
      lib,
      ...
    }: {
      imports = [
        inputs.stylix.nixosModules.stylix
      ];
      stylix = {
        enable = true;
      };
    };
  }
