":index_to_foreground(INT color_index, ?STR text) => STR";
"Return an ANSI foreground color sequence, or wrap text in that foreground color when text is supplied.";
{color_index, ?text = ""} = args;
if (color_index > length(this.color_names))
  raise(E_INVARG, "invalid color index");
endif
color_name = this.color_names[color_index];
return text ? $ansi:(color_name)(text) | $ansi:(color_name)();
