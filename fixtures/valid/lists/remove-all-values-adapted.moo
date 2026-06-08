":remove_all_values(LIST values, MIXED target) => LIST";
"Called by parsers to remove all occurrences of a filler value from a list.";
{values, target} = args;
while (index = target in values)
  values[index..index] = {};
endwhile
return values;
