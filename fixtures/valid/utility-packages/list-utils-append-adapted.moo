":append(LIST ...) => LIST";
"Return a single list containing the elements of each list argument.";
result = {};
for values in (args)
  result = {@result, @values};
endfor
return result;
