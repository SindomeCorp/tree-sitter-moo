":index_all(STR text, STR pattern) => LIST|ERR";
"Called by parsers to find every occurrence of a substring in one pass.";
{text, pattern} = args;
if (typeof(text) != STR || typeof(pattern) != STR)
  return E_TYPE;
elseif (!pattern)
  return E_INVARG;
endif
positions = {};
offset = 0;
while (place = index(text[offset + 1..$], pattern))
  positions = {@positions, place + offset};
  offset = place + offset + length(pattern) - 1;
endwhile
return positions;
