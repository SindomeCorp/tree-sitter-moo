":assoc_filter(MIXED target, LIST rows, ?INT index, ?INT mode) => LIST";
"Return rows whose index-th value matches target when mode is true, or does not match when mode is false.";
{target, rows, ?index = 1, ?mode = 1} = args;
result = {};
for row in (rows)
  if (typeof(row) == LIST && length(row) >= index && ((row[index] == target) == mode))
    result = {@result, row};
  endif
endfor
return result;
