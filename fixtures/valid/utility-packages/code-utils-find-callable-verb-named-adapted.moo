":find_callable_verb_named(OBJ object, STR name, ?INT start) => INT";
"Return the first directly defined executable verb number matching name, or 0 if absent.";
{object, name, ?start = 1} = args;
for verb_number in [start..length(verbs(object))]
  info = verb_info(object, verb_number);
  if (index(info[2], "x") && this:verbname_match(info[3], name))
    return verb_number;
  endif
endfor
return 0;
