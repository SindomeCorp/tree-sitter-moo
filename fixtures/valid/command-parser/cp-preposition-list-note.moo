":move() => none";
"Called by a player command using parser variables; demonstrates argspec any from any.";
if (prepstr != "from")
  player:tell("Use: move <thing> from <place>");
  return;
endif
player:tell("Moving ", dobjstr, " from ", iobjstr, ".");
