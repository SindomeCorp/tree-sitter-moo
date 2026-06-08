":split_first(STR text, STR delimiter) => LIST";
"Called by parsers that need {left, right} around the first delimiter.";
{text, delimiter} = args;
position = index(text, delimiter);
if (!position)
  return {text, ""};
endif
return {text[1..position - 1], text[position + length(delimiter)..$]};
