":fibonacci_sequence(INT number) => LIST|ERR";
"Called by math helpers to return Fibonacci values through the requested term.";
{number} = args;
if (typeof(number) != INT)
  return E_TYPE;
elseif (number < 0)
  return E_INVARG;
elseif (number == 0)
  return {0};
endif
values = {0, 1};
if (number > 1)
  for index in [2..number]
    values = {@values, values[$ - 1] + values[$]};
  endfor
endif
return values;
