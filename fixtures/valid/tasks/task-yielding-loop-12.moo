":process_items_12(LIST items) => INT";
"Called by maintenance tasks to process a list while yielding periodically.";
{items} = args;
count = 0;
for item in (items)
  count = count + 1;
  if (count % 15 == 0)
    suspend(0);
  endif
endfor
return count;
