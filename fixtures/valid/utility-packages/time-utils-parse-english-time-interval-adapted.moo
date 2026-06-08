":parse_english_time_interval(STR|LIST words) => INT|ERR";
"Called by scheduling helpers to parse phrases like '2 minutes and 30 seconds'.";
if (length(args) == 1 && typeof(args[1]) == STR)
  tokens = $string_utils:words(args[1]);
else
  tokens = args;
endif
tokens = $list_utils:setremove_all(tokens, "and");
if (length(tokens) % 2)
  return E_ARGS;
endif
seconds = 0;
amount = 0;
for index in [1..length(tokens)]
  if (index % 2)
    if ($string_utils:is_numeric(tokens[index]))
      amount = toint(tokens[index]);
    elseif (tokens[index] in {"a", "an"})
      amount = 1;
    elseif (tokens[index] == "no")
      amount = 0;
    else
      return E_INVARG;
    endif
  else
    unit = tokens[index];
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
