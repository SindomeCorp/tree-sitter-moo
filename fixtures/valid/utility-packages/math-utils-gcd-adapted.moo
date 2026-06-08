":gcd(INT left, INT right) => INT";
"Called by numeric helpers to find the greatest common divisor.";
{left, right} = args;
left = abs(left);
right = abs(right);
if (!left)
  return right;
elseif (!right)
  return left;
endif
while (right)
  remainder = left % right;
  left = right;
  right = remainder;
endwhile
return left;
