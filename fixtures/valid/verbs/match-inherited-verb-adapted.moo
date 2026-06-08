":match_inherited_verb(OBJ object, STR verbname) => LIST|INT";
"Called by code tools that need the object where a verb is actually defined.";
{object, verbname} = args;
verbname = strsub(verbname, "*", "");
while (E_VERBNF == (info = `verb_info(object, verbname) ! E_VERBNF, E_INVARG'))
  object = parent(object);
endwhile
return info ? {object, verbname} | 0;
