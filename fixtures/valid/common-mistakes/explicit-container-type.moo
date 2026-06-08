":ensure_map(MIXED cache) => MAP";
"Called by cache helpers to preserve empty maps instead of treating them as uninitialized.";
{cache} = args;
if (typeof(cache) != MAP)
  cache = [];
endif
return cache;
