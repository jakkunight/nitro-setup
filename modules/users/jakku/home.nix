let
  user = "jakku";
in
{ den, ... }:
{
  den.aspects."${user}-home".homeManager = {
    imports =
      with den.aspects;
      map
        (
          a:
          if builtins.isAttrs a && a ? homeManager then
            (
              let
                v = a.homeManager;
              in
              if builtins.isAttrs v && v ? __contentValues then
                { imports = map (d: d.value) v.__contentValues; }
              else
                v
            )
          else if builtins.isAttrs a && a ? provides then
            { }
          else
            a
        )
        [
          devenv
          core
          kanagawa-theme
          zed
          gaming
          nightmare-desktop
          swaync
          kde
          libreoffice
          nightmare-helix
          brave
          asciinema
          audacity
          kdenlive
          krita
          gimp
          terminal-gadgets
          wanderer-fastfetch
          obs-studio-nvidia
          opencode
          llama-cpp
          openspec
        ];
    home = {
      stateVersion = "26.11";
      uid = 1000;
    };
  };
}
