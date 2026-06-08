":schedule_for(INT delay, OBJ object, STR verb_name, ?LIST optional_args) => INT|ERR";
"Add a one-shot scheduler task to run object:verb_name delay seconds from now.";
{delay, object, verb_name, ?optional_args = {}} = args;
if (!valid(object))
  return E_INVARG;
endif
runtime = time() + delay;
task = {0, object, verb_name, runtime, caller_perms(), optional_args};
this.scheduled_tasks = {@this.scheduled_tasks, task};
return 1;
