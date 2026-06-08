":match_verb(OBJ object, STR verb_name) => LIST|INT";
"Return {defining_object, normalized_verb_name} when object or an ancestor defines verb_name; return 0 otherwise.";
{object, verb_name} = args;
verb_name = strsub(verb_name, "*", "");
while (E_VERBNF == (info = `verb_info(object, verb_name) ! E_VERBNF, E_INVARG'))
  object = parent(object);
endwhile
return info ? {object, verb_name} | 0;
