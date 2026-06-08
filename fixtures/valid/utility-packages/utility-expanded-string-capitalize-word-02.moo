":capitalize_word_2(STR text) => STR";
"Called by utility package examples to demonstrate a focused helper pattern.";
{text} = args;
if (!text)
  return text;
endif
return $string_utils:uppercase(text[1]) + text[2..$];
