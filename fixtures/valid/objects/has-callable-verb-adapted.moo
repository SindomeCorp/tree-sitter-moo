":has_callable_verb(OBJ object, STR verbname) => LIST|INT";
"Called by validation helpers to determine whether object or an ancestor defines an executable verb.";
{object, verbname} = args;
while (valid(object))
  if (`index(verb_info(object, verbname)[2], "x") ! E_VERBNF => 0' && verb_code(object, verbname))
    return {object};
  endif
  object = parent(object);
endwhile
return 0;
