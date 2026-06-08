":flag_enabled(MAP flags, STR key) => BOOL";
"Called by ToastStunt-only helpers that store true BOOL values in MAPs.";
{flags, key} = args;
if (typeof(flags) != MAP)
  return false;
endif
return `flags[key] ! E_RANGE => false' == true;
