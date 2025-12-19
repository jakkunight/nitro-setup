{
  flake.modules.homeManager."text-editor/helix" =
    { pkgs, ... }:
    {
      programs.helix.languages = {
        language-server = {
        };
        language = [
        ];
      };
    };
}
