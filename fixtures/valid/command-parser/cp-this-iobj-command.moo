":pour() => none";
"Called by a player command using parser variables; demonstrates argspec this into any.";
if (dobj != this || !valid(iobj))
  player:tell("Usage: pour ", this.name, " into <container>");
  return;
endif
move(this, iobj);
player:tell("Poured into ", iobj.name, ".");
