":find_callable_verb_named(OBJ object, STR name, ?INT start) => INT";
"Called by code utilities to find a directly defined executable verb matching a name.";
{object, name, ?start = 1} = args;
for i in [start..length(verbs(object))]
  info = verb_info(object, i);
  if (index(info[2], "x") && $code_utils:verbname_match(info[3], name))
    return i;
  endif
endfor
return 0;
