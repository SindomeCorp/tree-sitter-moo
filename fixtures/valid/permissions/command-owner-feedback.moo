"Command body for `set-note any any any`.";
"Uses argstr for free-form text and player:tell() for command feedback.";
if (player != this.owner && !player.wizard)
  player:tell("Only the owner can change this note.");
  return;
endif
if (!length(argstr))
  player:tell("Set note to what?");
  return;
endif
this.note = argstr;
player:tell("Note updated.");
