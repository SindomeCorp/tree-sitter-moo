":setreplace_all(LIST values, MIXED search, MIXED replacement) => LIST";
"Return values with every occurrence of search replaced by replacement.";
{values, search, replacement} = args;
position = search in values;
while (position)
  if (typeof(replacement) == LIST)
    values[position..position] = {@replacement};
  else
    values[position..position] = {replacement};
  endif
  position = search in values;
endwhile
return values;
