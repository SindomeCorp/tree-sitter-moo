":even_numbers(INT stop) => LIST";
"Called by loop examples to produce even numbers up to stop.";
{stop} = args;
result = {};
value = 2;
while (value <= stop)
  result = {@result, value};
  value = value + 2;
endwhile
return result;
