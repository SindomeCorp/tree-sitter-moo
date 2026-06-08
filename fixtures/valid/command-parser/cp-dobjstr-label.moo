":@label() => none";
"Called by a player command using parser variables; demonstrates argspec any any any.";
if (!dobjstr)
  player:tell("Usage: @label <text>");
  return;
endif
this.label = dobjstr;
player:tell("Label set to ", this.label, ".");
