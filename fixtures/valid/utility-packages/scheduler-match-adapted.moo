":match(STR name) => OBJ|INT";
"Return the first scheduled task object whose name matches name, or 0.";
{name} = args;
for task in (this.scheduled_tasks)
  object = task[2];
  if (valid(object) && object.name == name)
    return object;
  endif
endfor
return 0;
