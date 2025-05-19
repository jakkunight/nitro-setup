_: {
  imports = [
    ./notifications
    ./statusline
    ./dashboard
    ./bufferline
    ./filetree
    ./filefinder
    ./terminal
  ];
  programs.nvf.settings.vim = {
    theme = {
      enable = true;
      name = "tokyonight";
      style = "night";
    };

    mini = {
      icons = {
        enable = true;
      };
      indentscope = {
        enable = true;
        setupOpts = {
          symbol = "│";
        };
      };
      trailspace = {
        enable = true;
      };
      hipatterns = {
        enable = true;
      };
      cursorword = {
        enable = true;
      };
      ai.enable = true;
      operators.enable = true;
      splitjoin.enable = true;
      basics.enable = true;
      align.enable = true;
    };
  };
}
