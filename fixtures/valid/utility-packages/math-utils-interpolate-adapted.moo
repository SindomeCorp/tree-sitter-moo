":interpolate(LIST start, LIST target, FLOAT ratio) => LIST";
"Called by animation/math helpers to find a point between two coordinate lists.";
{start, target, ratio} = args;
if (ratio < 0.0 || ratio > 1.0)
  raise(E_INVARG);
elseif (length(start) < 2 || length(start) > 3)
  raise(E_INVARG);
elseif (length(target) != length(start))
  raise(E_INVARG);
endif
middle = start;
middle[1] = tofloat(start[1]) + tofloat(target[1] - start[1]) * ratio;
middle[2] = tofloat(start[2]) + tofloat(target[2] - start[2]) * ratio;
if (length(start) > 2)
  middle[3] = tofloat(start[3]) + tofloat(target[3] - start[3]) * ratio;
endif
return middle;
