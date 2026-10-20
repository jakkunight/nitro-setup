class: aspect:
let
  value = aspect.${class} or { };
in
if builtins.isAttrs value && value ? __contentValues then
  { imports = map (d: d.value) value.__contentValues; }
else
  value
