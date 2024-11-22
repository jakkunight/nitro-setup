{ pkgs, inputs, ... }:
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
          # ltex = {
          #   enable = true;
          #   settings = {
          #     language = "es-AR";
          #   };
          # };
	  bashls = {
	    enable = true;
          };
          emmet_ls = {
            enable = true;
            autostart = true;
            filetypes = [
              "rust"
              "html"
              "tsx"
              "jsx"
              "js"
              "ts"
            ];
          };
          jdtls = {
            enable = true;
          };
          kotlin_language_server = {
            enable = true;
          };
	  pylyzer = {
	    enable = true;
	  };
	  nixd = {
            enable = true;
            autostart = true;

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
	  lua_ls = {
	    enable = true;
	  };
	  ccls = {
	    enable = true;
	  };
          ts_ls = {
            enable = true;
          };
          cssls = {
            enable = true;
          };
          grammarly = {
            enable = true;
            package = pkgs.emacsPackages.lsp-grammarly;
          };
	};
      };
      ts-autotag = {
        enable = true;
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
