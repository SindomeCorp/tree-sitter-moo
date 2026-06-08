":@lock() => none";
"Called by a player command using parser variables; demonstrates argspec none none none.";
this.locked = !this.locked;
player:tell("Locked: ", this.locked);
