":is_integer(STR text) => INT";
"Called by parsers before converting user-provided text with toint().";
{text} = args;
if (typeof(text) != STR)
  return 0;
endif
return match(text, "^ *[-+]?[0-9]+ *$") != 0;
