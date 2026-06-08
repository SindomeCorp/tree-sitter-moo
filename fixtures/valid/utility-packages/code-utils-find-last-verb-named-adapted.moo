":find_last_verb_named(OBJ object, STR name, ?INT last) => INT";
"Return the last directly defined verb number matching name, or -1 if absent.";
{object, name, ?last = -1} = args;
if (last < 0)
  last = length(verbs(object));
endif
for offset in [0..last - 1]
  verb_number = last - offset;
  if (this:verbname_match(verb_info(object, verb_number)[3], name))
    return verb_number;
  endif
endfor
return -1;
