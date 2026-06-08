":map_decorator_to_flag(STR decorator) => STR";
"Called by color-tag builders to encode decorator names into one-character flags.";
{decorator} = args;
if (decorator == "reset" || decorator == "normal")
  return "n";
elseif (decorator == "faint")
  return "t";
elseif (decorator == "bold")
  return "b";
elseif (decorator == "underline")
  return "u";
elseif (decorator == "italic")
  return "i";
elseif (decorator == "bgreset")
  return "r";
elseif (decorator == "blink")
  return "f";
endif
return "";
