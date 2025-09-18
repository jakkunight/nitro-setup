{
  pkgs,
  inputs,
  ...
}: {
  services.greetd = {
    enable = true;
    # settings = {
    #   default_session = {
    #     command = "${inputs.hyprland.packages.x86_64-linux.hyprland}/bin/Hyprland";
    #   };
    # };
  };
}
