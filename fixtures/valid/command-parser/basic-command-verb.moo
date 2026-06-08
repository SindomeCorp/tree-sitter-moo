if (!valid(dobj))
  player:tell("You do not see that here.");
  return;
endif

player:tell("You push " + dobj.name + ".");
