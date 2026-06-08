":isoneof(OBJ object, LIST ancestors) => INT";
"Called by type guards to test whether an object inherits from any object in a list.";
{object, ancestors} = args;
while (valid(object))
  if (object in ancestors)
    return 1;
  endif
  object = parent(object);
endwhile
return 0;
