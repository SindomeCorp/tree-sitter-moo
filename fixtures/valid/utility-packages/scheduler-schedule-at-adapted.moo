":schedule_at(INT runtime, OBJ object, STR verb_name, ?LIST optional_args) => INT|ERR";
"Add a one-shot scheduler task to run object:verb_name at runtime.";
{runtime, object, verb_name, ?optional_args = {}} = args;
if (!valid(object))
  return E_INVARG;
endif
task = {0, object, verb_name, runtime, caller_perms(), optional_args};
if (this.processing)
  this.incoming_tasks = {@this.incoming_tasks, task};
else
  this.scheduled_tasks = {@this.scheduled_tasks, task};
endif
return 1;
