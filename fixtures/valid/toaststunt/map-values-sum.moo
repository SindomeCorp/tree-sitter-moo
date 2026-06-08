":map_values_sum(MAP counts) => INT";
"Called by ToastStunt-only analytics helpers to total count values.";
{counts} = args;
total = 0;
for value in (mapvalues(counts))
  total = total + value;
endfor
return total;
