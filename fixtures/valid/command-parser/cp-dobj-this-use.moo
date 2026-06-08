":use() => none";
"Called by a player command using parser variables; demonstrates argspec any on this.";
if (!valid(dobj))
  player:tell("Use what on ", this.name, "?");
  return;
endif
this.last_used = dobj;
player:tell("You use ", dobj.name, " on ", this.name, ".");
