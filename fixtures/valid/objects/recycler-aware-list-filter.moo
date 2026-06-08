":valid_objects(LIST objects) => LIST";
"Called by object-list helpers on cores where $recycler:valid differs from valid().";
{objects} = args;
result = {};
for object in (objects)
  if ($recycler:valid(object))
    result = {@result, object};
  endif
endfor
return result;
