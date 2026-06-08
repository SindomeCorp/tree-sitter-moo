":assoc_index(MIXED target, LIST rows, ?INT index) => LIST";
"Called by lookup helpers to return the first row whose indexed element matches target.";
{target, rows, ?index = 1} = args;
for row in (rows)
  $command_utils:suspend_if_needed(0);
  if (`row[index] == target ! E_TYPE, E_RANGE => 0')
    if (typeof(row) == LIST && length(row) >= index)
      return row;
    endif
  endif
endfor
return {};
