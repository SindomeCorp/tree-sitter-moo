":flatten_list(LIST nested) => LIST";
"Called by normalization helpers to turn nested lists into a flat list.";
{nested} = args;
result = {};
for value in (nested)
  if (typeof(value) == LIST)
    result = {@result, @this:flatten_list(value)};
  else
    result = {@result, value};
  endif
endfor
return result;
