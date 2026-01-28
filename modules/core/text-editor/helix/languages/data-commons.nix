{
  flake.modules.homeManager."text-editor/helix" = {pkgs, ...}: {
    home.packages = with pkgs; [
      yaml-language-server
      taplo
      vscode-json-languageserver
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
          name = "json";
          auto-format = true;
          formatter = {
            command = "${pkgs.jsonfmt}/bin/jsonfmt";
          };
        }
        {
          name = "yaml";
          auto-format = true;
          formatter = {
            command = "${pkgs.yamlfmt}/bin/yamlfmt";
            args = [
              "-"
            ];
          };
        }
        {
          name = "toml";
          auto-format = true;
          formatter = {
            command = "${pkgs.taplo}/bin/taplo";
            args = [
              "format"
              "-"
            ];
          };
        }
      ];
    };
  };
}
