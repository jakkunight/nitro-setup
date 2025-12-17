{
  flake.modules.home."text-editor/helix" = {pkgs, ...}: {
    programs.helix.languages = {
      language-server = {
        language = [
        ];
      };
    };
  };
}
