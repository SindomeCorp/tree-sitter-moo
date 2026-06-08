":frequency_map(LIST values) => MAP";
"Called by ToastStunt-only analytics helpers that can use native map storage.";
{values} = args;
counts = [];
for value in (values)
  counts[value] = `counts[value] ! E_RANGE => 0' + 1;
endfor
return counts;
