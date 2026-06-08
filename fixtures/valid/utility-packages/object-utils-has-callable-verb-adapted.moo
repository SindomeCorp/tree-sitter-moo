":has_callable_verb(OBJ object, STR verb_name) => LIST|INT";
"Return {defining_object} when object or an ancestor has callable verb_name; otherwise return 0.";
{object, verb_name} = args;
while (valid(object))
  info = `verb_info(object, verb_name) ! E_VERBNF => 0';
  if (info && index(info[2], "x"))
    return {object};
  endif
  object = parent(object);
endwhile
return 0;
