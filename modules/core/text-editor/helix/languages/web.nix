{
  flake.modules.homeManager."text-editor/helix" = {pkgs, ...}: {
    home.packages = with pkgs; [
      vscode-css-languageserver
      superhtml
      typescript-language-server
    ];
    programs.helix.languages = {
      # language-server.tinymist = {
      #   command = "${pkgs.tinymist}/bin/tinymist";
      # };

      language = [
        # {
        #   name = "typst";
        #   auto-format = true;
        #   formatter = {
        #     command = "${pkgs.typstyle}/bin/typstyle";
        #     args = [
        #       "-i"
        #       "-t"
        #       "4"
        #     ];
        #   };
        #   language-servers = [
        #     "tinymist"
        #   ];
        # }
        {
          name = "html";
          auto-format = true;
        }
        {
          name = "css";
          auto-format = true;
        }
        {
          name = "javascript";
          auto-format = true;
        }
      ];
    };
  };
}
