":substitute(STR text, LIST substitutions) => STR";
"Called by code-formatting helpers to replace tokens outside quoted strings.";
{text, substitutions} = args;
letters = "abcdefghijklmnopqrstuvwxyz0123456789";
for pair in (substitutions)
  target = pair[1];
  replacement = pair[2];
  target_length = length(target);
  delimited = index(letters, target[1]) && index(letters, target[target_length]);
  prefix = "";
  while (position = index(text, target))
    prefix = prefix + text[1..position - 1];
    left_ok = prefix == "" || !delimited || !index(letters, prefix[$]);
    right_ok = !delimited || position + target_length > length(text) || !index(letters, text[position + target_length]);
    if (left_ok && right_ok && !$code_utils:inside_quotes(prefix))
      prefix = prefix + replacement;
    else
      prefix = prefix + text[position..position + target_length - 1];
    endif
    text = text[position + target_length..$];
  endwhile
  text = prefix + text;
endfor
return text;
