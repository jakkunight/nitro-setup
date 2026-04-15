let
  feature = "kanagawa-dragon";
  theme = {
    # Fondo principal (background)
    base00 = "#181616";
    # Fondo alternativo (lighter background)
    base01 = "#282727";
    # Fondo de selección (selection background)
    base02 = "#393836";
    # Líneas, comentarios (comments, line highlights)
    base03 = "#625e5a";
    # Color de fondo para terminal oscura (dark terminal background)
    base04 = "#737c73";
    # Color de texto principal (foreground)
    base05 = "#c5c9c5";
    # Color de texto secundario (light foreground)
    base06 = "#c8c093";
    # Fondo claro / texto invertido (light background / inverted text)
    base07 = "#c5c9c5";
    # Rojo / variables, errores (red, variables, errors)
    base08 = "#c4746e";
    # Naranja / constantes, números (orange, constants, numbers)
    base09 = "#b6927b";
    # Amarillo / atributos, clases (yellow, attributes, classes)
    base0A = "#c4b28a";
    # Verde / cadenas, strings (green, strings)
    base0B = "#8a9a7b";
    # Cian / títulos, soporte (cyan, titles, support)
    base0C = "#8ea4a2";
    # Azul / funciones, métodos (blue, functions, methods)
    base0D = "#8ba4b0";
    # Magenta / palabras clave (magenta, keywords)
    base0E = "#a292a3";
    # Marrón / deprecated, eliminado (brown, deprecated, deleted)
    base0F = "#b98d7b";
    # Base10: fondo de menús, resaltado (menus, highlighted background)
    base10 = "#12120f";
    # Base11: bordes, separadores (borders, separators)
    base11 = "#0d0c0c";
    # Base12: rojo brillante (bright red)
    base12 = "#e46876";
    # Base13: verde brillante (bright green)
    base13 = "#e6c384";
    # Base14: amarillo brillante (bright yellow)
    base14 = "#87a987";
    # Base15: azul brillante (bright blue)
    base15 = "#7aa89f";
    # Base16: magenta brillante (bright magenta)
    base16 = "#7fb4ca";
    # Base17: cian brillante (bright cyan)
    base17 = "#938aa9";
  };
in
{
  flake.modules = {
    nixos.${feature} = {
      stylix.base16Scheme = theme;
    };
    homeManager.${feature} =
      { lib, ... }:
      {
        stylix.base16Scheme = theme;
        # programs.helix.settings.theme = lib.mkForce "kanagawa-dragon";
      };
  };
}
