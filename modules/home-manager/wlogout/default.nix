{pkgs, ...}: {
  programs.wlogout = {
    enable = true;
    # NOTE:
    # Using `systemctl` because modern Linux uses it.
    layout = [
      {
        text = "Power Off";
        action = "systemctl poweroff";
      }
      {
        text = "Reboot";
        action = "systemctl reboot";
      }
      {
        text = "Logout";
        action = "${pkgs.uwsm}/bin/uwsm stop";
      }
      {
        text = "Lock Screen";
        action = "${pkgs.uwsm}/bin/uwsm app -- ${pkgs.hyprlock}/bin/hyprlock";
      }
      {
        text = "Suspend";
        action = "systemctl suspend";
      }
      {
        text = "Hibernate";
        action = "systemctl hibernate";
      }
    ];
  };
}
