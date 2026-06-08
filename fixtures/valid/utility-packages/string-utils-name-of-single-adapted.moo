":name_of_single(LIST items, ?INT width) => LIST";
"Return display labels for the valid objects in items.";
{items, ?width = 20} = args;
result = {};
object_width = length(tostr(toint(max_object()))) + 1;
for item in (items)
  $command_utils:suspend_if_needed(0);
  if (typeof(item) == OBJ && valid(item))
    label = tostr($string_utils:left(item.name, width * -1), " (", $string_utils:left(item, object_width), ")");
    result = setadd(result, label);
  endif
endfor
return result;
