":check_nonstring_tell_lines(LIST lines) => INT";
"Record caller stack diagnostics when a wizard-owned helper sees non-string tell_lines input.";
{lines} = args;
if (!caller_perms().wizard)
  return 0;
endif
for line in (lines)
  if (typeof(line) != STR)
    this.nonstring_tell_lines = listappend(this.nonstring_tell_lines, callers());
    return 1;
  endif
endfor
return 0;
