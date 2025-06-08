{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  config = lib.mkIf config.configurations.system.stylix {
    stylix = {
      base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
      image = ./assets/wallpapers/wanderer-and-aranaras.jpeg;
      fonts = {
        monospace = {
          package = pkgs.nerd-fonts.caskaydia-cove;
          name = "CaskadyaCoveNerdFont";
        };
        sansSerif = {
          package = inputs.genshin-font.packages.${pkgs.system}.default;
          name = "Genshin Impact";
        };
        serif = {
          package = inputs.genshin-font.packages.${pkgs.system}.default;
          name = "Genshin Impact";
        };
        sizes = {
          applications = 12;
          terminal = 14;
          desktop = 12;
          popups = 10;
        };
      };
      polarity = "dark";
    };
  };
}
