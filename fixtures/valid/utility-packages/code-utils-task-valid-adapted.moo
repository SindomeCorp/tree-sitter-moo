":task_valid(INT task) => INT";
"Return true iff task is the current task or appears to be a valid queued task.";
{task} = args;
set_task_perms($no_one);
return task == task_id() || E_PERM == `kill_task(task) ! ANY';
