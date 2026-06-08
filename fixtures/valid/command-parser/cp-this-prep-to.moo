":attach() => none";
"Called by a player command using parser variables; demonstrates argspec this to any.";
if (dobj != this || !valid(iobj))
  player:tell("Usage: attach ", this.name, " to <target>");
  return;
endif
this.attached_to = iobj;
player:tell("Attached to ", iobj.name, ".");
