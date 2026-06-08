":findable_properties(OBJ object) => LIST";
"Return properties readable by caller_perms() or owned by caller_perms() on object and its ancestors.";
{object} = args;
result = {};
who = caller_perms();
while (valid(object))
  if (object.r || who == object.owner || who.wizard)
    result = {@properties(object), @result};
  endif
  object = parent(object);
endwhile
return result;
