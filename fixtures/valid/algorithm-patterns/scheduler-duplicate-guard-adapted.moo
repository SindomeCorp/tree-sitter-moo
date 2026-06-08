":add_scheduled_task(LIST tasks, LIST incoming_tasks, LIST task, ?INT processing, ?INT allow_duplicates) => LIST|ERR";
"Called by scheduling APIs to add a task without losing tasks queued during processing.";
{tasks, incoming_tasks, task, ?processing = 0, ?allow_duplicates = 0} = args;
{repeat, object, verb_name, runtime, owner, ?opargs = {}} = task;
if (!allow_duplicates)
  for existing in (tasks)
    if (existing[2] == object && existing[3] == verb_name)
      return E_INVARG;
    endif
  endfor
  for existing in (incoming_tasks)
    if (existing[2] == object && existing[3] == verb_name)
      return E_INVARG;
    endif
  endfor
endif
if (processing)
  incoming_tasks = {@incoming_tasks, task};
else
  tasks = {@tasks, task};
endif
return {tasks, incoming_tasks};
