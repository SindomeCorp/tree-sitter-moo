":toerr(INT|STR value) => ERR|INT";
"Called by code utilities that accept either E_FOO names or numeric error positions.";
{value} = args;
if (typeof(value) != STR)
  index = toint(value) + 1;
  if (index > length(this.error_list))
    return 1;
  endif
elseif (!(index = value in this.error_names || "E_" + value in this.error_names))
  return 1;
endif
return this.error_list[index];
