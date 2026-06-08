":filter_values(MAP source, INT minimum) => MAP";
"Called by ToastStunt-only cache helpers to keep entries at or above minimum.";
{source, minimum} = args;
filtered = [];
for key in (mapkeys(source))
  if (source[key] >= minimum)
    filtered[key] = source[key];
  endif
endfor
return filtered;
