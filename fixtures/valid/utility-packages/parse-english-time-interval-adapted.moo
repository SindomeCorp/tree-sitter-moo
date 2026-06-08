":parse_english_time_interval(@STR words) => INT|ERR";
"Called by scheduling helpers to convert text such as '2 minutes and 30 seconds' into seconds.";
if (length(args) == 1 && index(args[1], " "))
  return this:parse_english_time_interval(@$string_utils:words(args[1]));
endif
tokens = $list_utils:setremove_all(args, "and");
if (length(tokens) % 2)
  return E_ARGS;
endif
seconds = 0;
for i in [1..length(tokens)]
  if (i % 2)
    if ($string_utils:is_numeric(tokens[i]))
      amount = toint(tokens[i]);
    elseif (tokens[i] in {"a", "an"})
      amount = 1;
    else
      return E_INVARG;
    endif
  else
    unit = tokens[i];
    if (unit[$] == ",")
      unit = unit[1..$ - 1];
    endif
    matched = 0;
    for entry in ($time_utils.time_units)
      if (!matched && unit in entry[2..$])
        seconds = seconds + entry[1] * amount;
        matched = 1;
      endif
    endfor
    if (!matched)
      return E_INVARG;
    endif
  endif
endfor
return seconds;
