":inspect() => none";
"Called by a player command using parser variables; demonstrates argspec any none none.";
if (!valid(dobj))
  player:tell("You do not see ", dobjstr, " here.");
  return;
endif
player:tell("You inspect ", dobj.name, ".");
