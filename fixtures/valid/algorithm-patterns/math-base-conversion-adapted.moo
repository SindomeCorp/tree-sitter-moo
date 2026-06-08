":convert_base(MIXED value, INT source_base, INT target_base) => STR|ERR";
"Called by math helpers to convert numbers between bases up to base 62.";
{value, source_base, target_base} = args;
alphabet = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
if (source_base < 2 || target_base < 2 || source_base > 62 || target_base > 62)
  return E_INVARG;
endif
input = tostr(value);
number = 0;
for index in [1..length(input)]
  digit = index(alphabet, input[index]);
  if (!digit || digit > source_base)
    return E_INVARG;
  endif
  number = number * source_base + digit - 1;
endfor
if (number == 0)
  return "0";
endif
output = "";
while (number)
  digit = number % target_base;
  output = alphabet[digit + 1] + output;
  number = number / target_base;
endwhile
return output;
