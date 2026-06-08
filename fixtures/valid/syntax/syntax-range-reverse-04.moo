":range_reverse_4(@MIXED values) => MIXED";
"called by syntax tests to traverse a string backward.";
{text} = args;
result = "";
for index in [length(text)..1]
  result = result + text[index];
endfor
return result;
