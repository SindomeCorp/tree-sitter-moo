":recycle_checked(OBJ item) => INT|ERR";
"Called by cleanup tools to recycle an object only when the caller controls it.";
{item} = args;
if (!$perm_utils:controls(caller_perms(), item))
  raise(E_PERM);
elseif (is_player(item))
  raise(E_INVARG);
elseif (`item:recycle_denied() ! E_VERBNF => 0')
  raise(E_PERM);
elseif (`item.recycle_denied ! E_PROPNF => 0')
  return E_PERM;
endif
this:add_orphan(item);
result = `$building_utils:recreate(item, $garbage) ! E_PERM, E_INVARG, E_QUOTA';
if (typeof(result) == ERR)
  return result;
endif
this:remove_orphan(item);
item.name = tostr("Recyclable ", item);
move(item, $recycler);
return 1;
