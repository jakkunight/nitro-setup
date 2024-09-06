{
  programs.nixvim = {
    plugins = {
      rust-tools = {
	enable = true;
      };
      trouble.enable = true;
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
      todo-comments = {
	enable = true;
	settings = {
	  signs = true;
	  merge_keywords = true;
	  colors = {
	    default = [
	      "Identifier"
	      "#7C3AED"
	    ];
	    error = [
	      "DiagnosticError"
	      "ErrorMsg"
	      "#DC2626"
	    ];
	    hint = [
	      "DiagnosticHint"
	      "#10B981"
	    ];
	    info = [
	      "DiagnosticInfo"
	      "#2563EB"
	    ];
	    test = [
	      "Identifier"
	      "#FF00FF"
	    ];
	    warning = [
	      "DiagnosticWarn"
	      "WarningMsg"
	      "#FBBF24"
	    ];
	  };
	  highlight = {
	    multiline = true; # enable multine todo comments
	    multiline_pattern = "^."; # lua pattern to match the next multiline from the start of the matched keyword
	    multiline_context = 10; # extra lines that will be re-evaluated when changing a line
	    before = ""; # "fg" or "bg" or empty
	    keyword = "wide"; # "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
	    after = "fg"; # "fg" or "bg" or empty
	    pattern = "[[.*<(KEYWORDS)\s*:]]"; # pattern or table of patterns, used for highlighting (vim regex)
	    comments_only = true; # uses treesitter to match keywords in comments only
	    max_line_len = 400; # ignore lines longer than this
	    exclude = []; # list of file types to exclude highlighting
	  };
	  # keywords recognized as todo comments
	  keywords = {
	    FIX = {
	      icon = " "; # icon used for the sign, and in search results
	      color = "error"; # can be a hex color, or a named color (see below)
	      alt = [ "FIXME" "BUG" "FIXIT" "ISSUE" ]; # a set of other keywords that all map to this FIX keywords
	      # signs = false, # configure signs for some keywords individually
	    };
	    TODO = { icon = " "; color = "info"; };
	    HACK = { icon = " "; color = "warning"; };
	    WARN = { icon = " "; color = "warning"; alt = [ "WARNING" "XXX" ]; };
	    PERF = { icon = " "; alt = [ "OPTIM" "PERFORMANCE" "OPTIMIZE" ]; };
	    NOTE = { icon = " "; color = "hint"; alt = [ "INFO" ]; };
	    TEST = { icon = "⏲ "; color = "test"; alt = [ "TESTING" "PASSED" "FAILED" ]; };
	  };
	};
      };
    };
  };
}
