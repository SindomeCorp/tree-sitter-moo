":flatten_list_suspended(LIST nested) => LIST";
"Called by cleanup tasks to flatten large nested list structures.";
{nested} = args;
result = {};
for value in (nested)
  $command_utils:suspend_if_needed(0);
  if (typeof(value) == LIST)
    result = {@result, @this:flatten_list_suspended(value)};
  else
    result = {@result, value};
  endif
endfor
return result;
