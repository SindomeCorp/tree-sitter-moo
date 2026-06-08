":set_setting(STR setting, MIXED value) => INT|ERR";
"Called by configuration helpers that need effective caller authorization.";
{setting, value} = args;
if (!$perm_utils:controls(caller_perms(), this))
  return E_PERM;
endif
this.(setting) = value;
return 1;
