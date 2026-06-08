":put() => none";
"Called by a player command using parser variables; demonstrates argspec any in this.";
if (!valid(dobj))
  player:tell("Put what in ", this.name, "?");
  return;
endif
move(dobj, this);
player:tell("You put ", dobj.name, " in ", this.name, ".");
