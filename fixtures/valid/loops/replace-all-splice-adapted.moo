":replace_all(LIST values, MIXED search, MIXED replacement) => LIST";
"Called by list normalization helpers to replace all matches with a scalar or spliced list.";
{values, search, replacement} = args;
while (index = search in values)
  if (typeof(replacement) == LIST)
    values[index..index] = {@replacement};
  else
    values[index..index] = {replacement};
  endif
endwhile
return values;
