{
  programs.nixvim = {
    extraConfigLua = ''
    '';
    plugins = {
      rustaceanvim = {
	enable = true;
      };
      typescript-tools = {
        enable = true;
      };
      trouble.enable = true;
      lsp = {
	enable = true;
	servers = {
	  bashls = {
	    enable = true;
          };
          emmet-ls = {
            enable = true;
            autostart = true;
            fileTypes = [
              "rust"
            ];
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
  imports = [
    ./lspsaga.nix
    ./ts-autotag.nix
  ];
}
