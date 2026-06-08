"bad: wrap every success path in another nested if.";
"fixed: use guard clauses to keep the main path shallow.";
{target} = args;
if (!valid(target))
  return E_INVARG;
endif
if (!target.enabled)
  return 0;
endif
return target:run_check();
