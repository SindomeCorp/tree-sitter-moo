":group_number(INT number, ?STR separator) => STR";
"Called by formatting helpers to insert a separator every three digits.";
{number, ?separator = ","} = args;
result = "";
sign = number < 0 ? "-" | "";
digits = tostr(abs(number));
while (length(digits) > 3)
  result = separator + digits[$ - 2..$] + result;
  digits = digits[1..$ - 3];
endwhile
return sign + digits + result;
