":select_shortest_path_candidates(LIST candidates, INT max_count) => LIST";
"Called by dispatcher-style helpers to choose the closest candidates first.";
{candidates, max_count} = args;
selected = {};
while (candidates && length(selected) < max_count)
  best_index = 1;
  best_length = length(candidates[1]);
  if (length(candidates) > 1)
    for index in [2..length(candidates)]
      if (length(candidates[index]) < best_length)
        best_index = index;
        best_length = length(candidates[index]);
      endif
    endfor
  endif
  selected = {@selected, candidates[best_index]};
  candidates[best_index..best_index] = {};
endwhile
return selected;
