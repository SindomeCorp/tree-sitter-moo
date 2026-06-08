":contains(OBJ container, OBJ object) => INT";
"Return true when object is inside container at any depth in the location hierarchy.";
{container, object} = args;
while (valid(object))
  object = object.location;
  if (object == container)
    return valid(container);
  endif
endwhile
return 0;
