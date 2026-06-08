":branch_descendants(OBJ object) => LIST";
"Called by object-tree tools to collect descendants that themselves have children.";
{object} = args;
frontier = {object};
index = 1;
while (index <= length(frontier))
  kids = children(frontier[index]);
  if (kids)
    frontier[index + 1..index] = kids;
    index = index + 1;
  else
    frontier[index..index] = {};
  endif
endwhile
return frontier;
