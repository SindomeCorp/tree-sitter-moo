":find_verb_named(OBJ object, STR name, ?INT start) => INT";
"Return the number of the first directly defined verb whose primary name is name; return 0 when absent.";
{object, name, ?start = 1} = args;
for verb_number in [start..length(verbs(object))]
  verb_name = verb_info(object, verb_number)[3];
  if (verb_name == name || index(verb_name, name + " ") == 1 || index(verb_name, " " + name + " ") || rindex(verb_name, " " + name) == length(verb_name) - length(name))
    return verb_number;
  endif
endfor
return 0;
