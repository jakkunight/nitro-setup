{
  flake.modules.homeManager."text-editor/helix" = {pkgs, ...}: {
    programs.helix.languages = {
      language-server = {
        markdown-oxide = {
          command = "${pkgs.markdown-oxide}/bin/markdown-oxide";
        };
        marksman = {
          command = "${pkgs.marksman}/bin/marksman";
          args = [
            "server"
          ];
        };

        language = [
          {
            name = "markdown";
            auto-format = true;
            formatter = {
              command = "${pkgs.deno}/bin/deno";
              args = [
                "fmt"
                "-"
                "--ext"
                "md"
              ];
            };
            language-servers = [
              {
                name = "marksman";
              }
              {
                name = "scls";
              }
            ];
          }
        ];
      };
    };
  };
}
