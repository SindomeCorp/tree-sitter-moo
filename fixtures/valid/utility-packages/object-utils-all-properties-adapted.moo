":all_properties(OBJ object) => LIST";
"Return readable properties defined on object and its ancestors.";
{object} = args;
result = {};
while (valid(object))
  result = {@`properties(object) ! E_PERM => {}', @result};
  object = parent(object);
endwhile
return result;
