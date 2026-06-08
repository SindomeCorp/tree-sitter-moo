":remove_duplicates(LIST values) => LIST";
"Return values with repeated elements removed.";
{values} = args;
result = {};
for value in (values)
  result = setadd(result, value);
endfor
return result;
