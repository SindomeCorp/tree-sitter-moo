":zip(LIST ...) => LIST|ERR";
"Return rows made from corresponding positions in each input list.";
longest = 0;
for column in (args)
  if (typeof(column) != LIST)
    return E_INVARG;
  endif
  longest = max(longest, length(column));
endfor
rows = {};
columns = length(args);
for row_index in [1..longest]
  row = $list_utils:make(columns);
  for column_index in [1..columns]
    row[column_index] = `args[column_index][row_index] ! E_RANGE => 0';
  endfor
  rows = {@rows, row};
endfor
return rows;
