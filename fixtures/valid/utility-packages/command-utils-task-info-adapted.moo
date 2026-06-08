":task_info(INT task) => LIST|ERR";
"Return the queued_tasks() row for task, or E_INVARG when it is not queued.";
{task} = args;
set_task_perms(caller_perms());
for queued in (queued_tasks())
  if (queued[1] == task)
    return queued;
  endif
endfor
return E_INVARG;
