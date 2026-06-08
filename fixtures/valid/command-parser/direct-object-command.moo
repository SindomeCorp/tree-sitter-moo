if (!valid(dobj))
  player:tell("You do not see " + dobjstr + " here.");
  return;
endif

player:tell("You inspect " + dobj.name + ".");
