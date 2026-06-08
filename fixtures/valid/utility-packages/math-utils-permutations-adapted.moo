":permutations(INT n, INT r) => INT|ERR";
"Called by probability helpers to count ordered selections.";
{n, r} = args;
if (typeof(n) != INT || typeof(r) != INT)
  return E_TYPE;
endif
if (r < 1 || n - r < 0)
  return 0;
endif
count = 1;
for value in [n - r + 1..n]
  count = count * value;
endfor
return count;
