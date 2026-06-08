":place() => none";
"Called by a player command using parser variables; demonstrates argspec any on this.";
if (!valid(dobj))
  player:tell("Place what on ", this.name, "?");
  return;
endif
this.surface_items = setadd(this.surface_items, dobj);
player:tell("Placed: ", dobj.name);
