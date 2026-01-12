_: {
  flake.modules.homeManager."desktop/nightmare/hyprlock" = {lib, ...}: {
    programs.hyprlock = {
      enable = true;
      # settings = {
      #   background = lib.mkForce [
      #     {
      #       path = lib.mkForce "../../theming/stylix/nightmare/wallpapers/9s-wallpaper-v2.jpg";
      #       # blur_passes = 3;
      #       # blur_size = 2;
      #     }
      #   ];
      # };
    };
  };
}
