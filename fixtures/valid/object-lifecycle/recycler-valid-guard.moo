":require_usable_object(OBJ object) => OBJ|ERR";
"Called by lifecycle helpers that must reject recycled garbage objects.";
{object} = args;
if (!$recycler:valid(object))
  return E_INVARG;
endif
return object;
