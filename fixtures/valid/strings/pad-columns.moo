":pad_columns(LIST rows, INT width) => LIST";
"Called by display helpers to pad the first column in two-column rows.";
{rows, width} = args;
output = {};
for row in (rows)
  label = row[1];
  while (length(label) < width)
    label = label + " ";
  endwhile
  output = {@output, tostr(label, row[2])};
endfor
return output;
