":task_owner(INT task) => OBJ|ERR";
"Return the owner of a queued task, or E_INVARG when the task is not queued.";
{task} = args;
row = $list_utils:assoc(task, queued_tasks());
return row ? row[5] | E_INVARG;
