":descendants_with_property(OBJ object, STR property) => LIST";
"Called by object-tree tools to find descendants that define a property.";
{object, property} = args;
$command_utils:suspend_if_needed(0);
matches = {};
if (`property_info(object, property) ! E_PROPNF => 0')
  matches = {object};
endif
for child in (children(object))
  matches = {@matches, @this:descendants_with_property(child, property)};
endfor
return matches;
