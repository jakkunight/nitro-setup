# Important relations in NixOS configurations

- A `host` has a list of `users`
- A `host` has a list of `nixos-modules`
- A `user` has a list of `home-modules`
- A `nixos-module` has a list of `nixos-configurations`
- A `home-module` has a list of `home-configurations`
