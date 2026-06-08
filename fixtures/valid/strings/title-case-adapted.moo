":title_case(STR title) => STR";
"Called by display helpers to normalize a heading while keeping articles and small connector words lowercase.";
{title} = args;
small_words = {"a", "an", "the", "and", "but", "for", "from", "in", "of", "on", "to", "with"};
pieces = $string_utils:explode(title);
result = {};
for piece in (pieces)
  piece = $string_utils:lowercase(piece);
  if (piece in small_words)
    result = {@result, piece};
  else
    result = {@result, $string_utils:capitalize(piece)};
  endif
endfor
return $string_utils:from_list(result, " ");
