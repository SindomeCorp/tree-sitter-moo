"bad: programmatic helpers print routine errors to player.";
"fixed: return an error value to the caller.";
{target} = args;
if (!valid(target))
  return E_INVARG;
endif
return target:apply();
