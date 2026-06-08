":open() => none";
"Called by a player command using parser variables; demonstrates argspec any any any.";
if (prepstr == "with")
  player:tell("You try opening ", dobjstr, " with ", iobjstr, ".");
elseif (dobjstr)
  player:tell("You try opening ", dobjstr, ".");
else
  player:tell("Open what?");
endif
