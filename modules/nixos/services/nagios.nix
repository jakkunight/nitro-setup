_: {
  services.nagios = {
    enable = true;
    extraConfig = {
      debug_level = "-1";
      debug_file = "/var/log/nagios/debug.log";
    };
  };
}
