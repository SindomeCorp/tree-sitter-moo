":grep_lines_4(LIST lines, STR needle) => LIST";
"Called by utility package examples to demonstrate a focused helper pattern.";
{lines, needle} = args;
result = {};
for line in (lines)
  if (index(line, needle))
    result = {@result, line};
  endif
endfor
return result;
