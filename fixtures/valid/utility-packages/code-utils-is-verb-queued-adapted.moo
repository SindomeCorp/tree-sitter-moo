":is_verb_queued(OBJ object, STR verb_name) => INT";
"Return 1 if queued_tasks() currently shows object:verb_name as queued; forked/suspended callees may obscure the original verb.";
{object, verb_name} = args;
for task in (queued_tasks())
  if (task[9] == object && task[7] == verb_name)
    return 1;
  endif
endfor
return 0;
