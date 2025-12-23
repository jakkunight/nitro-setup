{inputs, ...}: {
  flake.modules.nixos."secrets/sops" = {pkgs, ...}: {
    # SOPS-NIX:
    imports = [
      inputs.sops-nix.nixosModules.sops
    ];
    environment.systemPackages = with pkgs; [
      sops
      ssh-to-age
    ];
    sops = {
      defaultSopsFormat = "yaml";
    };
    # INFO: To reference a secret:
    # - Use `sops.secrets."my-secret"` for plain secrets in secrets.yaml
    # - Use `sops.secrets."my/nested/secret"` for nested secrets in secrets.yaml
    #
    # Keys are stored in decripted form after rebuild in `/run/secrets` and
    # belong to the `root` user by default. To allow another user to access it without
    # `sudo` use:
    # ```nix
    # sops.secrets."my-secret" = {
    #   owner = config.users.users.${your_user}.name;
    # };
    # ```
  };
}
