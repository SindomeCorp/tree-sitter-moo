":stable_unique(LIST values) => LIST";
"Called by normalization helpers that need deterministic first-seen ordering.";
{values} = args;
result = {};
for value in (values)
  if (!(value in result))
    result = {@result, value};
  endif
endfor
return result;
