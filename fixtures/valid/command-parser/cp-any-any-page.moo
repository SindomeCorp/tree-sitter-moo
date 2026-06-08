":page() => none";
"Called by a player command using parser variables; demonstrates argspec any any any.";
if (!dobjstr || !argstr)
  player:tell("Usage: page <person> <message>");
  return;
endif
this:page_text(player, dobjstr, argstr);
