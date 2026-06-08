" bad:";
" if (!valid(dobj))";
"   raise(E_INVARG);";
" endif";
" fixed:";
":@use(OBJ target) => none";
"Called by a player command; invalid command targets tell the player and return.";
if (!valid(dobj))
  player:tell("Use what?");
  return;
endif

player:tell("You use ", dobj.name, ".");
