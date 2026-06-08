" bad:";
" if (!valid(target))";
"   player:tell(\"Invalid target.\");";
"   return;";
" endif";
" fixed:";
":set_target(OBJ target) => INT|ERR";
"Called by other verbs; returns errors to the caller instead of printing player feedback.";
{target} = args;
if (!valid(target))
  return E_INVARG;
elseif (!$perm_utils:controls(caller_perms(), this))
  return E_PERM;
endif

this.target = target;
return 1;
