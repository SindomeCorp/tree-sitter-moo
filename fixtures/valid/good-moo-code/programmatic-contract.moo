":set_status(STR status) => INT|ERR";
"Called by setup helpers to update this.status; returns E_PERM if caller_perms() cannot control this object.";
{status} = args;
if (!$perm_utils:controls(caller_perms(), this))
  return E_PERM;
endif
this.status = status;
return 1;
