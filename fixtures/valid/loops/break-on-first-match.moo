":first_matching_row(LIST rows, MIXED key) => LIST";
"Called by lookup helpers that only need the first row whose first column matches key.";
{rows, key} = args;
match = {};
for row in (rows)
  if (typeof(row) == LIST && length(row) && row[1] == key)
    match = row;
    break;
  endif
endfor
return match;
