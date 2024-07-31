{
  programs.nixvim = {
    plugins = {
      lsp = {
	enable = true;
	servers = {
	  bashls = {
	    enable = true;
	  };
	  rust-analyzer = {
	    enable = true;
	    installCargo = true;
	    installRustc = true;
	  };
	  pylyzer = {
	    enable = true;
	  };
	  nixd = {
	    enable = true;
	  };
	  jsonls = {
	    enable = true;
	  };
	  yamlls = {
	    enable = true;
	  };
	  tsserver = {
	    enable = true;
	  };
	  marksman = {
	    enable = true;
	  };
	  lua-ls = {
	    enable = true;
	  };
	  sqls = {
	    enable = true;
	  };
	  ccls = {
	    enable = true;
	  };
	};
      };
      lsp-format = {
	enable = true;
      };
      lsp-lines = {
	enable = true;
      };
      lsp-status = {
	enable = true;
      };
    };
  };
}
