":repair() => none";
"Called by 'repair this with <tool>' when this object owns the command verb.";
if (dobj != this)
  player:tell("You need to repair this object directly.");
  return;
elseif (!valid(iobj))
  player:tell("Repair it with what?");
  return;
endif
this:repair_with(player, iobj);
player:tell("You start repairing ", this.name, " with ", iobj.name, ".");
