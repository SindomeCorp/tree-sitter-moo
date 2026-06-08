":sort_objects_by_property(LIST objects, ?STR property) => LIST";
"Called by display helpers to order objects by a comparable property value.";
{objects, ?property = "name"} = args;
$command_utils:suspend_if_needed(0);
if (length(objects) <= 1)
  return objects;
endif
pivot = objects[1];
left = {};
right = {};
for index in [2..length(objects)]
  if (objects[index].(property) < pivot.(property))
    left = {@left, objects[index]};
  else
    right = {@right, objects[index]};
  endif
endfor
return {@this:sort_objects_by_property(left, property), pivot, @this:sort_objects_by_property(right, property)};
