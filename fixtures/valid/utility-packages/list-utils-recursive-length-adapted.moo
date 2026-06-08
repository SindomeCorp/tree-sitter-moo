":recursive_length(LIST values, ?INT recurse) => INT";
"Return length(values), or include nested list lengths when recurse is true.";
{values, ?recurse = 0} = args;
total = length(values);
if (!recurse)
  return total;
endif
for value in (values)
  if (typeof(value) == LIST)
    total = total + this:recursive_length(value, recurse);
  endif
  $command_utils:suspend_if_needed(0);
endfor
return total;
