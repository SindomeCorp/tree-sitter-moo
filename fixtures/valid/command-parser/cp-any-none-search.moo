":search() => none";
"Called by a player command using parser variables; demonstrates argspec any none none.";
needle = dobjstr;
if (!needle)
  player:tell("Search for what?");
  return;
endif
player:tell("Searching for ", needle, ".");
