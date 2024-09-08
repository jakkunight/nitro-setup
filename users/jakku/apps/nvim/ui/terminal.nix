{
  programs.nixvim = {
    plugins = {
      toggleterm = {
	enable = true;
	settings = {
	  autochdir = true;
	  close_on_exit = true;
	  direction = "horizontal";
	};
      };
    };
  };
}
