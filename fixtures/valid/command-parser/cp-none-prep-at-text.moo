":wave() => none";
"Called by a player command using parser variables; demonstrates argspec none at any.";
if (valid(iobj))
  player:tell("You wave at ", iobj.name, ".");
else
  player:tell("You wave at ", iobjstr, ".");
endif
