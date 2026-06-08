":owned_properties(OBJ object, ?OBJ owner) => LIST";
"Return visible properties on object and ancestors owned by owner or caller_perms().";
{object, ?owner = caller_perms()} = args;
if (!caller_perms().wizard)
  owner = caller_perms();
endif
properties_found = {};
ancestor = object;
while (valid(ancestor))
  for prop in (properties(ancestor))
    info = `property_info(object, prop) ! E_PROPNF, E_PERM => 0';
    if (info && info[1] == owner)
      properties_found = {@properties_found, prop};
    endif
  endfor
  ancestor = parent(ancestor);
endwhile
return properties_found;
