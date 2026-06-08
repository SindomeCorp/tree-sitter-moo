":@rename() => none";
"Called by players as `@rename <new name>`; uses argstr from the command parser and tells the player on failure.";
if (!argstr)
  player:tell("Usage: @rename <new name>");
  return;
endif
this.name = argstr;
player:tell("Renamed to ", this.name, ".");
