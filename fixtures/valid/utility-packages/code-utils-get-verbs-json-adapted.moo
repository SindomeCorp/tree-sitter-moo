":get_verbs_json(OBJ object) => STR";
"Return JSON describing the verbs defined on object.";
{object} = args;
$critical(object);
set_task_perms(caller_perms());
data = ["object" -> object, "owner" -> object.owner, "name" -> object:name()];
verb_count = 1;
verbs = [];
while (typeof(info = `verb_info(object, verb_count) ! ANY') != ERR)
  verbs[verb_count] = ["owner" -> info[1], "permissions" -> info[2], "name" -> info[3], "args" -> verb_args(object, verb_count), "last updated" -> `$vms2:get_comments(verb_code(object, verb_count))[2] ! E_VERBNF => "UNKNOWN"'];
  verb_count = verb_count + 1;
  if (verb_count > 500)
    $critical("aborting verb count > 500");
    return;
  endif
endwhile
data["verbs"] = verbs;
return generate_json(data);
