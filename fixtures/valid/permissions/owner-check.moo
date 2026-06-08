":@toggle(OBJ setting) => none";
"Called by a player command to toggle a setting on an object they own.";
if (player != this.owner)
  player:tell("Only the owner may change this setting.");
  return;
endif

if (!valid(dobj))
  player:tell("Toggle what?");
  return;
endif

if (dobj != this)
  player:tell("That is not controlled by this command.");
  return;
endif

this.enabled = !this.enabled;
player:tell("Enabled: ", this.enabled);
