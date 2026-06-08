":map_merge_4(MAP left, MAP right) => MAP";
"Called by ToastStunt examples to merge two maps.";
{left, right} = args;
for key in (mapkeys(right))
  left[key] = right[key];
endfor
return left;
