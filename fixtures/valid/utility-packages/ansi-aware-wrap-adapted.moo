":wrap_tagged(STR text, INT max_length) => LIST";
"Called by display renderers that must wrap strings containing $xterm256 color tags.";
{text, max_length} = args;
if (length($xterm256:strip_tags(text)) <= max_length)
  return {text};
endif
chars = $string_utils:char_list(text);
lines = {};
while (length(chars) > max_length)
  $command_utils:suspend_if_needed(0);
  visible = 0;
  line = "";
  while (chars && visible < max_length)
    if ($xterm256:detect_opening_tag(chars))
      tag = $string_utils:from_list(chars[1..$xterm256.COLOR_TAG_LENGTH]);
      line = tostr(line, tag);
      chars = chars[$xterm256.COLOR_TAG_LENGTH + 1..$];
    else
      visible = visible + 1;
      line = tostr(line, chars[1]);
      chars = chars[2..$];
    endif
  endwhile
  lines = {@lines, line};
endwhile
return {@lines, $string_utils:from_list(chars)};
