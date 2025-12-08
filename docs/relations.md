# Important relations in NixOS configurations

- A `host` has a list of `users`
- A `host` has a list of `nixos-modules`
- A `user` has a list of `home-modules`
- A `nixos-module` has a list of `nixos-configurations`
- A `home-module` has a list of `home-configurations`

## Core things to have on ANY host

- [x] A text editor (Helix is my go-to choice).
- [x] Nix + Home-Manager to build the system.
- [x] NH as an alternative to Nix + Home-Manager.
- [x] A file manager (Yazi is my go-to choice).
- [x] Git + Gitui to use Flakes. (Mandatory).
- [x] A terminal multiplexer (Zellij is my go-to choice).
- [x] A system monitor (btop is my go-to choice).
- [x] A shell (ZSH is my go-to choice, but I also like Nushell).
- [x] Some secrets manager (like SOPS-Nix).
- [OPTIONAL] [ ] Some customization tool (Stylix is my preferred choice).
- [OPTIONAL] [ ] Some music player (RMPC is my go-to choice).
- [OPTIONAL] [ ] Devenv/Devbox to get development setups effortlessly.
