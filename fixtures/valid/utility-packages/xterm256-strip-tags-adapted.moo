":strip_tags(STR text) => STR";
"Called by plain-text output paths before sending ANSI-tagged text to clients that should not see tags.";
{text} = args;
opening = $xterm256.escape + "(";
if (!index(text, opening))
  return text;
endif
current = 1;
while (start = index(text[current..$], opening))
  start = start + current - 1;
  tag = text[start..min($, start + $xterm256.COLOR_TAG_LENGTH - 1)];
  text = strsub(text, tag, "");
  current = start;
endwhile
return text;
