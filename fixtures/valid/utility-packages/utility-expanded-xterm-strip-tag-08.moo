":strip_tag_8(STR text) => STR";
"Called by utility package examples to demonstrate a focused helper pattern.";
{text} = args;
start = index(text, "<");
finish = index(text, ">");
if (start && finish > start)
  return text[1..start - 1] + text[finish + 1..$];
endif
return text;
