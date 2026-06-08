" bad:";
" {name} = args;";
" this.name = name;";
" fixed:";
":@rename(STR new_name) => none";
"Called by a player command; uses parser text instead of destructuring command args.";
if (!dobjstr)
  player:tell("Usage: @rename <new name>");
  return;
endif

this.name = dobjstr;
player:tell("Name set to ", this.name, ".");
