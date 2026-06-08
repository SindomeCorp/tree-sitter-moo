":extreme_by_length(LIST values, ?INT want_shortest) => MIXED|ERR";
"Called by formatting helpers to choose the longest or shortest string/list element.";
{values, ?want_shortest = 0} = args;
if (!values)
  return E_RANGE;
endif
result = values[1];
for value in (values)
  if (typeof(value) != LIST && typeof(value) != STR)
    return E_TYPE;
  elseif (want_shortest && length(value) < length(result))
    result = value;
  elseif (!want_shortest && length(value) > length(result))
    result = value;
  endif
endfor
return result;
