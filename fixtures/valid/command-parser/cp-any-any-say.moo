":say() => none";
"Called by a player command using parser variables; demonstrates argspec any any any.";
if (!argstr)
  player:tell("Say what?");
  return;
endif
this:announce(player.name, " says, ", argstr);
