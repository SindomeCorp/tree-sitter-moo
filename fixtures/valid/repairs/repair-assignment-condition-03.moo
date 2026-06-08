"bad: if (position = needle in values)";
"fixed: assign before the conditional.";
{needle, values} = args;
position = needle in values;
if (position)
  return values[position];
endif
return 0;
