{
  flake.modules.homeManager."text-editor/helix" = {pkgs, ...}: {
    programs.helix.languages = {
      language-server = {
        tinymist = {
          command = "${pkgs.tinymist}/bin/tinymist";
        };

        language = [
          {
            name = "typst";
            auto-format = true;
            formatter = {
              command = "${pkgs.typstyle}/bin/typstyle";
              args = [
                "-i"
                "-t"
                "4"
              ];
            };
            language-servers = [
              {
                name = "tinymist";
              }
            ];
          }
        ];
      };
    };
  };
}
