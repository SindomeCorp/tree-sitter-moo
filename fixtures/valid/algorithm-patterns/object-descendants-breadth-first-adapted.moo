":descendants_breadth_first(OBJ object) => LIST";
"Called by object-tree tools to collect all descendants portably.";
{object} = args;
result = children(object);
index = 1;
while (index <= length(result))
  $command_utils:suspend_if_needed(0);
  kids = children(result[index]);
  if (kids)
    result = {@result, @kids};
  endif
  index = index + 1;
endwhile
return result;
