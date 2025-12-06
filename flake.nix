{
  description = "Your new project, powered by flake-parts!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };
  outputs = {flake-parts, ...} @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        # Anything that declares a `perSystem` attribute.
      ];
      systems = ["x86_64-linux"];
      perSystem = {
        config,
        self',
        inputs',
        pkgs,
        system,
        ...
      }: {
        # Outputs of a regular flake.nix that depends on a specific
        # `system` attribute.
        # Allows definition of system-specific attributes
        # without needing to declare the system explicitly!
        #
        # Quick rundown of the provided arguments:
        # - config is a reference to the full configuration, lazily evaluated
        # - self' is the outputs as provided here, without system. (self'.packages.default)
        # - inputs' is the input without needing to specify system (inputs'.foo.packages.bar)
        # - pkgs is an instance of nixpkgs for your specific system
        # - system is the system this configuration is for

        # This is equivalent to packages.<system>.default
        # packages.default = pkgs.hello;
      };
      # flake = {
      #   # The usual flake attributes can be defined here, including
      #   # system-agnostic and/or arbitrary outputs.
      # };
    };
}
