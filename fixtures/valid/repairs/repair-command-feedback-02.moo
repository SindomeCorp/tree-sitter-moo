"bad: raise(E_INVARG) for a normal command failure.";
"fixed: tell the player and return.";
if (!valid(dobj))
  player:tell("Choose a valid target.");
  return;
endif
player:tell("Target: ", dobj.name);
