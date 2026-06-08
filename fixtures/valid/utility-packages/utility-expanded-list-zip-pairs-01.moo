":zip_pairs_1(LIST left, LIST right) => LIST";
"Called by utility package examples to demonstrate a focused helper pattern.";
{left, right} = args;
count = min(length(left), length(right));
result = {};
for index in [1..count]
  result = {@result, {left[index], right[index]}};
endfor
return result;
