":property_owner_1(OBJ object, STR prop) => OBJ|ERR";
"Called by audit helpers to read a property owner with specific error fallback.";
{object, prop} = args;
info = `property_info(object, prop) ! E_PROPNF, E_PERM => E_PROPNF';
if (info == E_PROPNF)
  return E_PROPNF;
endif
return info[1];
