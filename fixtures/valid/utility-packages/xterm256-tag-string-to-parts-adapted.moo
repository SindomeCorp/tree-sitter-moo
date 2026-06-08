":tag_string_to_parts(STR text) => LIST";
"Called by color-aware formatting helpers before measuring or transforming tagged strings.";
{text} = args;
parts = {};
pointer = 1;
part = "";
while (pointer <= length(text))
  if ($xterm256:detect_opening_tag(text[pointer..$]))
    if (part)
      parts = {@parts, part};
    endif
    parts = {@parts, text[pointer..pointer + $xterm256.COLOR_TAG_LENGTH - 1]};
    pointer = pointer + $xterm256.COLOR_TAG_LENGTH;
    part = "";
  else
    part = part + text[pointer];
    pointer = pointer + 1;
  endif
endwhile
if (part)
  parts = {@parts, part};
endif
return parts;
