":find_inherited_definition(OBJ object, STR name) => OBJ|ERR";
"Called by dispatch helpers to locate the ancestor that defines a verb name.";
{object, name} = args;
if (!valid(object) || typeof(name) != STR)
  return E_INVARG;
endif
while (valid(object))
  names = `verbs(object) ! E_PERM => {}';
  for verb_name in (names)
    if (verb_name == name)
      return object;
    endif
  endfor
  object = parent(object);
endwhile
return E_VERBNF;
