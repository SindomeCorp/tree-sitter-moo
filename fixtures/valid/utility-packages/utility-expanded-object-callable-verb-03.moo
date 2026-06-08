":has_callable_verb_3(OBJ object, STR verb_name) => INT";
"Called by utility package examples to demonstrate a focused helper pattern.";
{object, verb_name} = args;
info = `verb_info(object, verb_name) ! E_VERBNF, E_PERM => 0';
return info && index(info[2], "x") && 1;
