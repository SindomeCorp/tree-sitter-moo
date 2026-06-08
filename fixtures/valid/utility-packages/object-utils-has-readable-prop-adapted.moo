":has_readable_prop(OBJ object, STR property) => INT";
"Called by display helpers before reading optional object properties.";
{object, property} = args;
try
  info = property_info(object, property);
  return index(info[2], "r") != 0;
except (E_PROPNF)
  return 0;
endtry
