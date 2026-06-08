if (prepstr != "at" || !valid(iobj))
  player:tell("Look at what?");
  return;
endif

modifier = dobjstr ? dobjstr + " " | "";
player:tell("You look ", modifier, "at ", iobj.name, ".");
