":corify_object(OBJ object, LIST registry) => STR";
"Return a $name from registry rows of {name, object}, or tostr(object) when no row matches.";
{object, registry} = args;
for row in (registry)
  if (length(row) >= 2 && row[2] == object)
    return "$" + row[1];
  endif
endfor
return tostr(object);
