":slice(LIST rows, ?INT index) => LIST";
"Return the index-th field from each row in a list of lists.";
{rows, ?index = 1} = args;
result = {};
for row in (rows)
  $command_utils:suspend_if_needed(0);
  result = {@result, row[index]};
endfor
return result;
