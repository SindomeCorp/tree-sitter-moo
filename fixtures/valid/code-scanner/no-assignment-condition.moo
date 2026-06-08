":find_position(MIXED needle, LIST values) => INT";
"Called by scanner examples to avoid assignment inside if or while conditions.";
{needle, values} = args;
position = needle in values;
if (position)
  return position;
endif
return 0;
