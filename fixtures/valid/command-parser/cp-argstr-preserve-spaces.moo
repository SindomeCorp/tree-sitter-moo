":@memo() => none";
"Called by a player command using parser variables; demonstrates argspec any any any.";
if (!argstr)
  player:tell("Usage: @memo <text>");
  return;
endif
this.memo = argstr;
player:tell("Memo saved.");
