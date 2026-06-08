":check_target(OBJ target) => INT|ERR";
"Called by scanner examples to keep validation flat and readable.";
{target} = args;
if (!valid(target))
  return E_INVARG;
endif
if (!target.enabled)
  return 0;
endif
return target:check();
