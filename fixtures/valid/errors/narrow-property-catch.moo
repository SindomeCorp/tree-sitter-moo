":property_or_default(OBJ object, STR property, MIXED fallback) => MIXED";
"Called by display helpers that can tolerate a missing optional property.";
{object, property, fallback} = args;
try
  return object.(property);
except (E_PROPNF)
  return fallback;
endtry
