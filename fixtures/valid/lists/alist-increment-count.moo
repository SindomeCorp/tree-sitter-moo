":alist_increment_count(LIST rows, ANY key) => LIST";
"Called by portable histogram builders to increment a key count.";
{rows, key} = args;
for index in [1..length(rows)]
  if (rows[index][1] == key)
    rows[index] = {key, rows[index][2] + 1};
    return rows;
  endif
endfor
return {@rows, {key, 1}};
