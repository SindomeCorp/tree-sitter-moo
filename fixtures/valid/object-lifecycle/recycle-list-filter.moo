":valid_objects_only(LIST objects) => LIST";
"Called before batch lifecycle operations to discard invalid object references.";
{objects} = args;
result = {};
for object in (objects)
  if (typeof(object) == OBJ && valid(object))
    result = {@result, object};
  endif
endfor
return result;
