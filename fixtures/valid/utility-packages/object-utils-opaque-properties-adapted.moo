":opaque_properties(OBJ object) => LIST";
"Return properties from $object_utils:all_properties(object) that are not clear inherited properties.";
{object} = args;
result = $object_utils:all_properties(object);
for prop in (result)
  try
    if (is_clear_property(object, prop))
      result = setremove(result, prop);
    endif
  except (E_PERM)
    result = setremove(result, prop);
  except (E_INVARG)
    " Ignore properties that are not valid on this object.";
  endtry
endfor
return result;
