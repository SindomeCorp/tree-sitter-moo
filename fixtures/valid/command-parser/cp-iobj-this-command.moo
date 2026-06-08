":load() => none";
"Called by a player command using parser variables; demonstrates argspec any into this.";
if (!valid(dobj) || iobj != this)
  player:tell("Usage: load <thing> into ", this.name);
  return;
endif
move(dobj, this);
player:tell("Loaded: ", dobj.name);
