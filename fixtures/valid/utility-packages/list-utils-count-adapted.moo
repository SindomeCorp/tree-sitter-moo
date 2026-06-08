":count(MIXED needle, LIST values) => INT";
"Return the number of times needle appears in values.";
{needle, values} = args;
count = 0;
for value in (values)
  if (value == needle)
    count = count + 1;
  endif
endfor
return count;
