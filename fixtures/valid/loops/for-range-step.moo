":numbered_lines(LIST values) => LIST";
"Called by display helpers to prefix each list item with its position.";
{values} = args;
output = {};
for i in [1..length(values)]
  output = {@output, tostr(i, ". ", values[i])};
endfor
return output;
