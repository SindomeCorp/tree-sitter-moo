":combinations(INT n, INT r) => INT|ERR";
"Called by probability helpers to count unordered choices.";
{n, r} = args;
if (typeof(n) != INT || typeof(r) != INT)
  return E_TYPE;
endif
r = min(r, n - r);
if (r < 0)
  return 0;
endif
count = 1;
n = n + 1;
for i in [1..r]
  count = count * (n - i) / i;
endfor
return count;
