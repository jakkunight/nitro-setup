{pkgs, ...}: {
  programs.nushell = {
    enable = true;
    configFile.text = ''
      $env.config = {
        show_banner: false,
        buffer_editor: ${pkgs.helix}/bin/hx,
      }
      clear
      ${pkgs.fastfetch}/bin/fastfetch
      echo "\n"
      echo "Welcome back, Jakku Night! (^.^)"
    '';
    loginFile.text = ''

    '';
  };
}
