":reverse_values(LIST values) => LIST";
"Called by list display helpers to return a reversed copy without mutating the input list.";
{values} = args;
if (length(values) > 50)
  midpoint = length(values) / 2;
  return {@this:reverse_values(values[midpoint + 1..$]), @this:reverse_values(values[1..midpoint])};
endif
result = {};
for value in (values)
  $command_utils:suspend_if_needed(0);
  result = listinsert(result, value);
endfor
return result;
