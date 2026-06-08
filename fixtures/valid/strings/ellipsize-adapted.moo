":ellipsize(STR text, INT max_length) => STR|ERR";
"Called by table and summary renderers to shorten long display text.";
{text, max_length} = args;
if (!text)
  return text;
elseif (max_length < 4)
  return E_INVARG;
elseif (length(text) <= max_length)
  return text;
endif
return tostr(text[1..max_length - 3], "...");
