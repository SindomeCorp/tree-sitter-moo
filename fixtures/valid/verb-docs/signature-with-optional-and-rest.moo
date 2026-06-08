":filter_values(LIST values, ?INT limit, @MIXED flags) => LIST";
"Called by report builders to filter values; optional limit caps the output and flags select filters.";
{values, ?limit = 10, @flags} = args;
output = {};
for value in (values)
  if (length(output) >= limit)
    break;
  elseif ("nonempty" in flags && !value)
    continue;
  endif
  output = {@output, value};
endfor
return output;
