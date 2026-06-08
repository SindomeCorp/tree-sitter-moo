":find_direct_definition(OBJ object, STR name) => OBJ|ERR";
"Called by code-inspection helpers to find whether object itself defines name.";
{object, name} = args;
if (!valid(object) || typeof(name) != STR)
  return E_INVARG;
endif
for verb_name in (verbs(object))
  if (verb_name == name)
    return object;
  endif
endfor
return E_VERBNF;
