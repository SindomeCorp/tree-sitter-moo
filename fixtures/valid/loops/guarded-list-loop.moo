if (length(args) < 1 || typeof(args[1]) != LIST)
  return {};
endif

results = {};
for item in (args[1])
  results = {@results, tostr(item)};
endfor
return results;
