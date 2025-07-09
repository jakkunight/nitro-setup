{pkgs, ...}: {
  services = {
    blueman-applet.enable = true;
    swaync = {
      enable = true;
    };
    udiskie = {
      enable = true;
      settings = {
        # workaround for
        # https://github.com/nix-community/home-manager/issues/632
        program_options = {
          # replace with your favorite file manager
          file_manager = "${pkgs.nemo}/bin/nemo";
        };
      };
    };
    remmina = {
      enable = true;
      systemdService.enable = true;
    };
  };
}
