{
  config,
  inputs,
  pkgs,
  ...
}: {
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-terminal-dark.yaml";
    fonts = {
      serif = {
        package = inputs.genshin-font.packages.${pkgs.system}.default;
        name = "Genshin Impact";
      };

      sansSerif = config.stylix.fonts.serif;

      monospace = {
        package = pkgs.nerd-fonts.hack;
        name = "Hack Nerd Font Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}
