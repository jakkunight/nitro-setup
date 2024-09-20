{
  programs.nixvim = {
    extraConfigLua = ''
      local lspconfig = require("lspconfig")
      lspconfig.init_options = {
	userLanguages = {
	  eelixir = "html-eex",
	  eruby = "erb",
	  rust = "html"
	}
      }
    '';
    plugins = {
      rustaceanvim = {
	enable = true;
      };
      trouble.enable = true;
      lsp = {
	enable = true;
	servers = {
	  bashls = {
	    enable = true;
	  };
	  # rust-analyzer = {
	  #   enable = true;
	  #   installCargo = true;
	  #   installRustc = true;
	  # };
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
      todo-comments = {
	enable = true;
      };
      comment = {
	enable = true;
	# INFO: To comment a selected text:
	#   + Use gb, for comment blocks.
	#   + Use gc, for commnet lsp-lines.
      };
      crates-nvim = {
	enable = true;
      };
    };
  };
}
