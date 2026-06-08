":call_named(OBJ object, STR name, LIST call_args) => ANY|ERR";
"Called by wrapper APIs that dispatch to a caller-selected helper verb.";
{object, name, call_args} = args;
if (!valid(object) || typeof(name) != STR || typeof(call_args) != LIST)
  return E_INVARG;
endif
return `object:(name)(@call_args) ! E_VERBNF, E_PERM, E_INVARG => E_INVARG';
