":display_code_differences(LIST old_lines, LIST new_lines, ?INT line_numbers) => LIST";
"Return display lines showing changed source lines from old_lines to new_lines.";
{old_lines, new_lines, ?line_numbers = 0} = args;
limit = max(length(old_lines), length(new_lines));
output = {};
for index in [1..limit]
  old = `old_lines[index] ! E_RANGE => ""';
  new = `new_lines[index] ! E_RANGE => ""';
  if (old != new)
    prefix = line_numbers ? tostr(index, ": ") | "";
    output = {@output, tostr(prefix, "- ", old), tostr(prefix, "+ ", new)};
  endif
endfor
return output;
