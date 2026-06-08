":side_by_side(?INT space, LIST ...) => LIST";
"Return display lines formed by placing paragraphs side by side with fixed spacing.";
{?space = 2, @paragraphs} = args;
widths = {};
max_lines = 0;
for paragraph in (paragraphs)
  width = 0;
  for line in (paragraph)
    width = max(width, length(line));
  endfor
  widths = {@widths, width};
  max_lines = max(max_lines, length(paragraph));
endfor
output = {};
for line_index in [1..max_lines]
  line = "";
  for paragraph_index in [1..length(paragraphs)]
    text = `paragraphs[paragraph_index][line_index] ! E_RANGE => ""';
    line = tostr(line, line ? $string_utils:space(space) | "", $string_utils:left(text, widths[paragraph_index]));
  endfor
  output = {@output, line};
endfor
return output;
