":names_of(LIST objects) => STR";
"Return a space-separated string of names for valid objects in objects.";
{objects} = args;
names = {};
for item in (objects)
  if (typeof(item) == OBJ && valid(item))
    names = {@names, `item:name() ! E_VERBNF => item.name'};
  endif
endfor
return $string_utils:from_list(names, " ");
