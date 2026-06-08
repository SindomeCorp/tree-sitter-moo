":group_by_column(LIST rows, ?INT column) => LIST";
"Called by table-formatting helpers to group rows by one column.";
{rows, ?column = 1} = args;
groups = {};
for row in (rows)
  key = row[column];
  found = 0;
  for index in [1..length(groups)]
    if (!found && groups[index][1] == key)
      groups[index][2] = {@groups[index][2], row};
      found = 1;
    endif
  endfor
  if (!found)
    groups = {@groups, {key, {row}}};
  endif
endfor
return groups;
