":compare() => none";
"Called by a player command using parser variables; demonstrates argspec any with any.";
if (prepstr != "with" || !valid(dobj) || !valid(iobj))
  player:tell("Usage: compare <thing> with <thing>");
  return;
endif
player:tell("You compare ", dobj.name, " with ", iobj.name, ".");
