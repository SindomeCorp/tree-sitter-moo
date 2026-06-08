":name_and_number(OBJ|LIST objects, ?STR separator) => STR";
"Return names and object numbers for one object or a list of objects.";
{objects, ?separator = " "} = args;
if (typeof(objects) != LIST)
  objects = {objects};
endif
names = {};
for object in (objects)
  name = $recycler:valid(object) ? object.name | (valid(object) ? object.name | "<invalid>");
  names = {@names, tostr(name, separator, "(", object, ")")};
endfor
return $string_utils:english_list(names);
