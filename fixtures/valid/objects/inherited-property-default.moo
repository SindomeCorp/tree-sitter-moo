":property_or_default(OBJ object, STR property, MIXED fallback) => MIXED";
"Called by object inspectors that need a safe property lookup.";
{object, property, fallback} = args;
info = `property_info(object, property) ! E_PROPNF, E_PERM => 0';
if (!info)
  return fallback;
endif
return object.(property);
