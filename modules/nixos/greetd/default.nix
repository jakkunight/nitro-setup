{
  pkgs,
  inputs,
  ...
}: {
  # programs.regreet.enable = true;
  services.greetd = {
    enable = true;
    settings = let
      hyprland_uwsm = {
        command = "${pkgs.tuigreet}/bin/tuigreet --cmd uwsm start hyprland-uwsm.desktop";
        user = "jakku";
      };
    in {
      default_session = hyprland_uwsm;
    };
  };
}
