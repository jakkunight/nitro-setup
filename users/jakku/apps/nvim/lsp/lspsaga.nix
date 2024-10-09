{
  programs.nixvim = {
    plugins.lspsaga = {
      enable = true;
      lightbulb = {
        enable = true;
        sign = false;
      };
    };
  };
}
