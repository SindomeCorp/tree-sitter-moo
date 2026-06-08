":branches(OBJ root) => LIST";
"Called by tree-view helpers to return descendants that are themselves branch nodes.";
{root} = args;
branches = {root};
index = 1;
while (index <= length(branches))
  kids = children(branches[index]);
  if (kids)
    branches[index + 1..index] = kids;
    index = index + 1;
  else
    branches[index..index] = {};
  endif
endwhile
return branches;
