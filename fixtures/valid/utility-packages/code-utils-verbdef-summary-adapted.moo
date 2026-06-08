":verbdef_summary(OBJ object, STR verb_name) => LIST|ERR";
"Return {defining_object, names, owner, permissions, argspec} for a direct or inherited verb.";
set_task_perms(caller_perms());
{object, verb_name} = args;
defined = $object_utils:has_verb(object, verb_name);
if (!defined)
  return E_VERBNF;
endif
object = defined[1];
info = `verb_info(object, verb_name) ! E_VERBNF, E_PERM => E_PERM';
if (info == E_PERM)
  return E_PERM;
endif
argspec = verb_args(object, verb_name);
return {object, info[3], info[1], info[2], argspec};
