":gcd_euclidean(INT left, INT right) => INT|ERR";
"Called by math helpers to compute the greatest common divisor.";
{left, right} = args;
if (typeof(left) != INT || typeof(right) != INT)
  return E_TYPE;
endif
if (left < 0)
  left = 0 - left;
endif
if (right < 0)
  right = 0 - right;
endif
if (left == 0)
  return right;
elseif (right == 0)
  return left;
endif
while (right != 0)
  remainder = left % right;
  left = right;
  right = remainder;
endwhile
return left;
