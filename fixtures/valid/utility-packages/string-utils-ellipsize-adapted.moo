":ellipsize(STR text, INT max_length) => STR";
"Called by display helpers to keep one-line labels within a fixed width.";
{text, max_length} = args;
if (!text)
  return text;
elseif (max_length < 4)
  raise(E_INVARG, "max_length must be greater than 3.");
elseif (length(text) <= max_length)
  return text;
endif
return tostr(text[1..max_length - 3], "...");
