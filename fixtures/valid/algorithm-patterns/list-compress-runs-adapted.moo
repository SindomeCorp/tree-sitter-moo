":compress_runs(LIST values) => LIST";
"Called by list normalization helpers to collapse adjacent repeated values.";
{values} = args;
if (!values)
  return values;
endif
last = values[1];
result = {last};
if (length(values) > 1)
  for value in (values[2..$])
    if (value != last)
      result = {@result, value};
      last = value;
    endif
  endfor
endif
return result;
