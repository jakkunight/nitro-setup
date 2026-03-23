let
  feature = "kanagawa-lotus";
  theme = {
    # Fondo principal (background)
    base00 = "#f2ecbc";
    # Fondo alternativo (lighter background) - derivado de selection.background
    base01 = "#c9cbd1";
    # Fondo de selección (selection background)
    base02 = "#c9cbd1";
    # Líneas, comentarios (comments, line highlights) - derivado de bright.black
    base03 = "#8a8980";
    # Color de fondo para terminal oscura (dark terminal background) - derivado de normal.white
    base04 = "#545464";
    # Color de texto principal (foreground)
    base05 = "#545464";
    # Color de texto secundario (light foreground) - derivado de bright.white
    base06 = "#43436c";
    # Fondo claro / texto invertido (light background / inverted text) - derivado de selection.foreground
    base07 = "#dcd7ba";
    # Rojo / variables, errores (red, variables, errors)
    base08 = "#c84053";
    # Naranja / constantes, números (orange, constants, numbers) - desde indexed_colors
    base09 = "#e98a00";
    # Amarillo / atributos, clases (yellow, attributes, classes)
    base0A = "#77713f";
    # Verde / cadenas, strings (green, strings)
    base0B = "#6f894e";
    # Cian / títulos, soporte (cyan, titles, support)
    base0C = "#597b75";
    # Azul / funciones, métodos (blue, functions, methods)
    base0D = "#4d699b";
    # Magenta / palabras clave (magenta, keywords)
    base0E = "#b35b79";
    # Marrón / deprecated, eliminado (brown, deprecated, deleted)
    base0F = "#836f4a";
    # Base10: fondo de menús, resaltado (menus, highlighted background) - derivado de bright.black
    base10 = "#8a8980";
    # Base11: bordes, separadores (borders, separators) - derivado de normal.black
    base11 = "#1f1f28";
    # Base12: rojo brillante (bright red)
    base12 = "#d7474b";
    # Base13: verde brillante (bright green)
    base13 = "#6e915f";
    # Base14: amarillo brillante (bright yellow)
    base14 = "#836f4a";
    # Base15: azul brillante (bright blue)
    base15 = "#6693bf";
    # Base16: magenta brillante (bright magenta)
    base16 = "#624c83";
    # Base17: cian brillante (bright cyan) - desde indexed_colors
    base17 = "#e82424";
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
