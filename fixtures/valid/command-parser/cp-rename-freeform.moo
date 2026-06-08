"Command body for `rename any any any`.";
"Uses argstr so names containing preposition words are preserved.";
if (!length(argstr))
  player:tell("Rename it to what?");
  return;
endif
this.name = argstr;
player:tell("Renamed to ", this.name, ".");
