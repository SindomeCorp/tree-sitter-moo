":count_occurrences(MIXED target, LIST values, ?INT yield) => INT|ERR";
"Called by list utilities to count occurrences of target without modifying the caller's original list.";
{target, values, ?yield = 0} = args;
if (typeof(values) != LIST)
  return E_INVARG;
endif
count = 0;
while (index = target in values)
  if (yield)
    $command_utils:suspend_if_needed(0);
  endif
  count = count + 1;
  values = values[index + 1..$];
endwhile
return count;
