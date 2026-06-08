":put() => none";
"Called by a player command using argspec any in any.";
if (!valid(dobj))
  player:tell("Put what?");
  return;
elseif (!valid(iobj))
  player:tell("Put it in what?");
  return;
elseif ($object_utils:contains(dobj, iobj))
  player:tell("That would create a containment loop.");
  return;
endif
result = `move(dobj, iobj) ! E_NACC, E_PERM, E_RECMOVE';
if (typeof(result) == ERR)
  player:tell("You cannot put ", dobj.name, " in ", iobj.name, ".");
  return;
endif
player:tell("You put ", dobj.name, " in ", iobj.name, ".");
