":filter_ignored(LIST values, LIST ignored) => LIST";
"Called by display helpers to remove ignored values while preserving order.";
{values, ignored} = args;
output = {};
for value in (values)
  if (value in ignored)
    continue;
  elseif (!value)
    continue;
  endif
  output = {@output, value};
endfor
return output;
