":polish() => none";
"Called by a player command using parser variables; demonstrates argspec this none none.";
if (dobj != this)
  player:tell("You cannot polish that with this command.");
  return;
endif
player:tell("You polish ", this.name, ".");
