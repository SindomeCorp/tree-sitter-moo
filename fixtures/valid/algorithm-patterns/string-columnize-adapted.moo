":columnize_items(LIST items, INT columns, ?INT width) => LIST";
"Called by command output helpers to format values into multiple text columns.";
{items, columns, ?width = 79} = args;
item_count = length(items);
height = (item_count + columns - 1) / columns;
items = {@items, @$list_utils:make(height * columns - item_count, "")};
column_widths = {};
for column in [1..columns - 1]
  column_widths = {@column_widths, 1 - (width + 1) * column / columns};
endfor
lines = {};
for row in [1..height]
  line = tostr(items[row]);
  for column in [1..columns - 1]
    line = tostr($string_utils:left(line, column_widths[column]), " ", items[row + column * height]);
  endfor
  if (length(line) > width)
    line = line[1..width];
  endif
  lines = {@lines, line};
endfor
return lines;
