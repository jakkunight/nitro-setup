_: {
  config = {
    programs.nvf.settings.vim = {
      spellcheck = {
        enable = true;
        languages = [
          "en"
          "es"
        ];
        programmingWordlist.enable = true;
      };

      lsp = {
        enable = true;
        formatOnSave = true;
        lspsaga.enable = true;
        trouble.enable = true;
      };
      notes = {
        todo-comments.enable = true;
      };
    };
  };
}
