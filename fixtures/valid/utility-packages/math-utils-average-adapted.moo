":average(LIST values | NUM ...) => INT|FLOAT";
"Return the average of a list of numbers or all provided numeric arguments.";
if (length(args) == 1 && typeof(args[1]) == LIST)
  values = args[1];
else
  values = args;
endif
total = $math_utils:sum(values);
count = length(values);
return total / (typeof(total) == FLOAT ? tofloat(count) | count);
