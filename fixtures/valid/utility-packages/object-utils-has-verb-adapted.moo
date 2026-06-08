":has_verb(OBJ object, STR verb_name) => LIST|INT";
"Return {defining_object} when object or an ancestor defines verb_name; otherwise return 0.";
{object, verb_name} = args;
while (E_VERBNF == (info = `verb_info(object, verb_name) ! E_VERBNF, E_INVARG'))
  object = parent(object);
endwhile
return info ? {object} | 0;
