" bad:";
" if (caller != this.owner)";
"   raise(E_PERM);";
" endif";
" fixed:";
":set_topic(STR topic) => INT";
"Called by another verb to update this.topic using the caller's effective permissions.";
{topic} = args;
if (!$perm_utils:controls(caller_perms(), this))
  raise(E_PERM);
endif

this.topic = topic;
return 1;
