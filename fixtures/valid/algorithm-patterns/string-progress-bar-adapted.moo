":plain_progress_bar(INT current, INT maximum, INT width) => STR";
"Called by status displays to render a simple proportional progress bar.";
{current, maximum, width} = args;
if (maximum <= 0)
  return E_INVARG;
endif
filled = toint(tofloat(current) / tofloat(maximum) * tofloat(width));
if (filled < 0)
  filled = 0;
elseif (filled > width)
  filled = width;
endif
return tostr("[", $string_utils:space(filled, "|"), $string_utils:space(width - filled, "."), "]");
