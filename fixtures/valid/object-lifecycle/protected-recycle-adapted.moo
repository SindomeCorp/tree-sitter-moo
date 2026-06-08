":protected_recycle(OBJ target) => INT|ERR";
"Called by protected object-management wrappers before permanently recycling an object.";
{target} = args;
who = caller_perms();
if (typeof(target) != OBJ)
  return E_TYPE;
elseif (!valid(target))
  return E_INVARG;
elseif (!$perm_utils:controls(who, target))
  return E_PERM;
elseif (is_player(target) && !who.wizard)
  return E_PERM;
endif

result = `recycle(target) ! E_PERM, E_INVARG';
return typeof(result) == ERR ? result | 1;
