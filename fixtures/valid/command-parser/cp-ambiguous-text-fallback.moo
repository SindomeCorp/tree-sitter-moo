":target() => none";
"Called by a player command using parser variables; demonstrates argspec any none none.";
if (!valid(dobj))
  this.pending_target_text = dobjstr;
  player:tell("Target text saved: ", dobjstr);
  return;
endif
this.target = dobj;
player:tell("Target set to ", dobj.name, ".");
