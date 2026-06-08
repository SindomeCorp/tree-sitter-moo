":factorial_iterative(INT number) => INT|ERR";
"Called by math helpers to calculate a small non-negative factorial.";
{number} = args;
if (typeof(number) != INT)
  return E_TYPE;
elseif (number < 0)
  return E_INVARG;
endif
result = 1;
if (number > 1)
  for value in [2..number]
    result = result * value;
  endfor
endif
return result;
