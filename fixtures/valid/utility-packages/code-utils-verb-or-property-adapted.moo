":verb_or_property(OBJ object, STR name, MIXED ...) => MIXED";
"Call object:name(@rest) if name is a verb; otherwise return object.(name) if it is a readable property.";
set_task_perms(caller_perms());
{object, name, @rest} = args;
return `object:(name)(@rest) ! E_VERBNF, E_INVIND => `object.(name) ! ANY'';
