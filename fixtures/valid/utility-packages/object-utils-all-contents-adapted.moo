":all_contents(OBJ container) => LIST";
"Called by inventory helpers to list nested contents at any depth.";
{container} = args;
results = {};
for item in (container.contents)
  results = {@results, item, @$object_utils:all_contents(item)};
endfor
return results;
