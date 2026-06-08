":ancestors(OBJ ...) => LIST";
"Return all valid ancestors of the supplied objects, with duplicates removed.";
result = {};
for object in (args)
  current = parent(object);
  while (valid(current))
    $command_utils:suspend_if_needed(0);
    result = setadd(result, current);
    current = parent(current);
  endwhile
endfor
return result;
