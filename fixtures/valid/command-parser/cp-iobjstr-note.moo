":write() => none";
"Called by a player command using parser variables; demonstrates argspec any on this.";
if (!dobjstr)
  player:tell("Write what on ", this.name, "?");
  return;
endif
this.note = dobjstr;
player:tell("You write on ", this.name, ".");
