let
  feature = "kanagawa-wave";
  theme = {
    # Meta:
    slug = "kanagawa-wave";
    scheme = "Kanagawa Wave";
    author = "Jakku Night";
    # Fondo principal (background)
    base00 = "#1f1f28";
    # Fondo alternativo (lighter background) - derivado de selection.background
    base01 = "#2d4f67";
    # Fondo de selección (selection background)
    base02 = "#2d4f67";
    # Líneas, comentarios (comments, line highlights) - derivado de bright.black
    base03 = "#727169";
    # Color de fondo para terminal oscura (dark terminal background) - derivado de normal.white
    base04 = "#c8c093";
    # Color de texto principal (foreground)
    base05 = "#dcd7ba";
    # Color de texto secundario (light foreground) - derivado de bright.white
    base06 = "#dcd7ba";
    # Fondo claro / texto invertido (light background / inverted text) - derivado de selection.foreground
    base07 = "#c8c093";
    # Rojo / variables, errores (red, variables, errors)
    base08 = "#c34043";
    # Naranja / constantes, números (orange, constants, numbers) - desde indexed_colors
    base09 = "#ffa066";
    # Amarillo / atributos, clases (yellow, attributes, classes)
    base0A = "#c0a36e";
    # Verde / cadenas, strings (green, strings)
    base0B = "#76946a";
    # Cian / títulos, soporte (cyan, titles, support)
    base0C = "#6a9589";
    # Azul / funciones, métodos (blue, functions, methods)
    base0D = "#7e9cd8";
    # Magenta / palabras clave (magenta, keywords)
    base0E = "#957fb8";
    # Marrón / deprecated, eliminado (brown, deprecated, deleted)
    base0F = "#e6c384";
    # Base10: fondo de menús, resaltado (menus, highlighted background) - derivado de bright.black
    base10 = "#727169";
    # Base11: bordes, separadores (borders, separators) - derivado de normal.black
    base11 = "#090618";
    # Base12: rojo brillante (bright red)
    base12 = "#e82424";
    # Base13: verde brillante (bright green)
    base13 = "#98bb6c";
    # Base14: amarillo brillante (bright yellow)
    base14 = "#e6c384";
    # Base15: azul brillante (bright blue)
    base15 = "#7fb4ca";
    # Base16: magenta brillante (bright magenta)
    base16 = "#938aa9";
    # Base17: cian brillante (bright cyan) - desde indexed_colors
    base17 = "#ff5d62";
  };
in
{
  flake.modules = {
    nixos.${feature} = {
      stylix.base16Scheme = theme;
    };
    homeManager.${feature} = {
      stylix.base16Scheme = theme;
    };
  };
}
