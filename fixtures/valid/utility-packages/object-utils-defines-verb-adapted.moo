":defines_verb(OBJ object, STR verb_name) => INT";
"Return 1 when object directly defines verb_name; return 0 otherwise.";
{object, verb_name} = args;
return `verb_info(object, verb_name) ! ANY => 0' && 1;
