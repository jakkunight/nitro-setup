{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  # https://devenv.sh/basics/
  env = {};

  # https://devenv.sh/packages/
  packages = [pkgs.git];

  # https://devenv.sh/languages/
  languages = {};

  # https://devenv.sh/processes/
  # processes.cargo-watch.exec = "cargo-watch";

  # https://devenv.sh/services/
  # services.postgres.enable = true;

  # https://devenv.sh/scripts/
  scripts = {
    build.exec = ''
      nix build .#nitro-intaller
    '';
  };

  enterShell = ''
  '';

  # https://devenv.sh/tasks/
  # tasks = {
  #   "nitro:test" = {
  #     exec = ''
  #       echo "[NIX] Running tests..."
  #       nix flake check . --show-trace --verbose --no-build
  #     '';
  #   };
  #   "nitro:build" = {
  #     exec = ''
  #       echo "[NIX] Building config for target host nitro..."
  #       nix build .#nitro --show-trace --verbose
  #     '';
  #   };
  # };

  # https://devenv.sh/tests/
  enterTest = ''
    nix flake check --show-trace --verbose --no-build
  '';

  # https://devenv.sh/git-hooks/
  # git-hooks.hooks.shellcheck.enable = true;

  # See full reference at https://devenv.sh/reference/options/
}
