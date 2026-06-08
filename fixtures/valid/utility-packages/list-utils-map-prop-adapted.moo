":map_property(LIST objects, STR property, ?MIXED missing) => LIST";
"Return the value of property on each object, substituting missing when supplied.";
{objects, property, ?missing = E_PROPNF} = args;
set_task_perms(caller_perms());
result = {};
for object in (objects)
  value = `object.(property) ! E_PROPNF => missing';
  result = {@result, value};
endfor
return result;
