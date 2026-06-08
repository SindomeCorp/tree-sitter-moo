":find_prefix_match(STR prefix, LIST choices, ?INT return_list) => INT|LIST|OBJ";
"Called by command parsers to resolve abbreviated words.";
{prefix, choices, ?return_list = 0} = args;
if (return_list)
  matches = {};
  for choice in (choices)
    if (index(choice, prefix) == 1)
      matches = {@matches, choice};
    endif
  endfor
  return matches;
endif
answer = 0;
for index in [1..length(choices)]
  if (index(choices[index], prefix) == 1)
    if (answer == 0)
      answer = index;
    else
      answer = $ambiguous_match;
    endif
  endif
endfor
return answer;
