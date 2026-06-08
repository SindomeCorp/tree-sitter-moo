":leaf_descendants(OBJ object) => LIST";
"Called by object-tree tools to collect descendants that have no children.";
{object} = args;
frontier = {object};
index = 1;
while (index <= length(frontier))
  kids = children(frontier[index]);
  if (kids)
    frontier[index..index] = kids;
  else
    index = index + 1;
  endif
endwhile
return frontier;
