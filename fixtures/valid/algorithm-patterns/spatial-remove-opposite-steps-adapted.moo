":remove_opposite_steps(LIST path) => LIST";
"Called by pathing helpers to collapse immediate backtracking from a direction list.";
{path} = args;
opposites = {{{"north", "n"}, {"south", "s"}}, {{"east", "e"}, {"west", "w"}}, {{"up", "u"}, {"down", "d"}}};
cleaned = {};
changed = 0;
while (length(path) > 1)
  $command_utils:suspend_if_needed(0);
  redundant = 0;
  for pair in (opposites)
    if ((path[1] in pair[1] && path[2] in pair[2]) || (path[1] in pair[2] && path[2] in pair[1]))
      redundant = 1;
      changed = 1;
      break;
    endif
  endfor
  if (redundant)
    if (length(path) > 2)
      path = path[3..$];
    else
      path = {};
    endif
  else
    cleaned = {@cleaned, path[1]};
    path = path[2..$];
  endif
endwhile
if (path)
  cleaned = {@cleaned, @path};
endif
return changed ? this:(verb)(cleaned) | cleaned;
