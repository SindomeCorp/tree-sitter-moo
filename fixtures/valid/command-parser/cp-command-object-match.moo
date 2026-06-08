":mark() => none";
"Called by a player command using parser variables; demonstrates argspec any none none.";
if (valid(dobj))
  this.marked = dobj;
  player:tell("Marked ", dobj.name, ".");
else
  player:tell("No match for ", dobjstr, ".");
endif
