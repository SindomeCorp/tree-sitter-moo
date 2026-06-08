cache = ["north" -> 1, "south" -> 2];
rows = {};
for value, key in (cache)
  rows = {@rows, {key, value}};
endfor
return rows;
