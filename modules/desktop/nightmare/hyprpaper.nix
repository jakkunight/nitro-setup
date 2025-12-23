_: {
  flake.modules.homeManager."desktop/nightmare/hyprpaper" = _: {
    services.hyprpaper = {
      enable = true;
      settings = {
        ipc = "on";
        splash = false;
      };
    };
  };
}
