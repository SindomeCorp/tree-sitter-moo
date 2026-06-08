":assoc_prefix(STR prefix, LIST rows, ?INT index) => LIST";
"Return the first row whose index-th element starts with prefix; return {} when no row matches.";
{prefix, rows, ?index = 1} = args;
for row in (rows)
  if (typeof(row) == LIST && length(row) >= index && index(row[index], prefix) == 1)
    return row;
  endif
endfor
return {};
