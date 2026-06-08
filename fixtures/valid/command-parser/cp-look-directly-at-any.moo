":look() => none";
"Called by 'look directly at John' and 'look at John' using argspec any at any.";
if (!valid(iobj))
  player:tell("Look at whom?");
  return;
endif
modifier = dobjstr ? dobjstr + " " | "";
player:tell("You look ", modifier, "at ", iobj.name, ".");
