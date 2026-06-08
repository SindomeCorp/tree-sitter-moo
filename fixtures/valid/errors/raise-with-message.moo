":require_name(STR name) => INT";
"Called by setup APIs that require a non-empty name and intentionally raise on invalid input.";
{name} = args;
if (!name)
  raise(E_INVARG, "Name is required.");
endif
this.name = name;
return 1;
