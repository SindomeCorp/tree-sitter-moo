":@tag() => none";
"Called by a player command using parser variables; demonstrates argspec any any any.";
if (length(args) < 1)
  player:tell("Usage: @tag <tag words>");
  return;
endif
this.tags = setadd(this.tags, $string_utils:from_list(args, " "));
player:tell("Tag added.");
