":iassoc_sorted(MIXED target, LIST rows, ?INT column) => INT";
"Called by sorted-list helpers to find the last row whose column is <= target.";
{target, rows, ?column = 1} = args;
left = 0;
right = length(rows) + 1;
while (right - 1 > left)
  middle = (right + left) / 2;
  if (target < rows[middle][column])
    right = middle;
  else
    left = middle;
  endif
endwhile
return left;
