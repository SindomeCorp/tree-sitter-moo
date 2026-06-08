" bad:";
" if (player != this.owner)";
"   raise(E_PERM);";
" endif";
" fixed:";
":@rename(STR new_name) => none";
"Called by a player command to rename an object they own.";
if (player != this.owner)
  player:tell("Only the owner may rename this.");
  return;
endif

if (!dobjstr)
  player:tell("Usage: @rename <new name>");
  return;
endif

this.name = dobjstr;
player:tell("Name set to ", this.name, ".");
