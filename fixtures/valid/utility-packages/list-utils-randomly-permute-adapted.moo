":randomly_permute(LIST values) => LIST";
"Return values in a random order.";
{values} = args;
result = {};
for index in [1..length(values)]
  result = listinsert(result, values[index], random(index));
  $command_utils:suspend_if_needed(0);
endfor
return result;
