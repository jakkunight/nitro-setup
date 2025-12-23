_: {
  flake.modules.homeManager."desktop/nightmare/hyprlock" = _: {
    programs.hyprlock = {
      enable = true;
    };
  };
}
