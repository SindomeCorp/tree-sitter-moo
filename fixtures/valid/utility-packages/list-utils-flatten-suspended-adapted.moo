":flatten_suspended(LIST values) => LIST";
"Return values flattened recursively.";
{values} = args;
result = {};
for value in (values)
  $command_utils:suspend_if_needed(0);
  if (typeof(value) == LIST)
    result = {@result, @this:flatten_suspended(value)};
  else
    result = {@result, value};
  endif
endfor
return result;
