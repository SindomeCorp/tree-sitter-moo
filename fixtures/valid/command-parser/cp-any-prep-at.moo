":look() => none";
"Called by a player command using parser variables; demonstrates argspec any at this.";
if (!valid(iobj))
  player:tell("Look at what?");
  return;
endif
style = dobjstr ? dobjstr | "carefully";
player:tell("You look ", style, " at ", iobj.name, ".");
