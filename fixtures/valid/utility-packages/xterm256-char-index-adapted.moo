":char_index(STR text) => INT";
"Return the index of the first visible character after leading xterm color tags, or 0 if no visible character exists.";
{text} = args;
original_length = length(text);
while (text)
  try
    if ($xterm256:detect_opening_tag(text))
      text = text[$xterm256.color_tag_length + 1..$];
      continue;
    endif
  except (E_RANGE)
    return 0;
  endtry
  return original_length - length(text) + 1;
endwhile
return 0;
