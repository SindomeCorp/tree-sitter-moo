":@seat() => none";
"Called by the @seat command to add a matched object to this.seats for the current room.";
if (player != this.owner && !$object_utils:isa(player, $builder))
  player:tell("Only the owner or a builder may add seats here.");
  return;
endif
if (!valid(dobj))
  player:tell("Seat what?");
  return;
endif
this.seats = setadd(this.seats, dobj);
player:tell("Seat added: ", dobj.name);
