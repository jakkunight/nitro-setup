let
  moduleName = "kanagawa-theme";
in
  {
    inputs,
    self,
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
        image = "${self."x86_64-linux".packages.wallpapers}/share/wallpapers/wanderer-sakura-wallpaper.jpg";
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
