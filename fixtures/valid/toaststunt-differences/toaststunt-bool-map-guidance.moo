":has_flag(STR key) => BOOL";
"Called by ToastStunt-only helpers that store true boolean values in a MAP.";
{key} = args;
flags = ["enabled" -> true, "hidden" -> false];
return `flags[key] ! E_RANGE => false';
