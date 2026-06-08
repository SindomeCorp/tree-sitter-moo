":parse_verbref(STR reference) => LIST|INT";
"Parse a string like `$thing:verb` or `object:verb` into {object_text, verb_name}; return 0 on failure.";
{reference} = args;
colon = index(reference, ":");
if (!colon)
  return 0;
endif
object_text = reference[1..colon - 1];
verb_name = reference[colon + 1..$];
if (!(object_text && verb_name))
  return 0;
endif
return {object_text, verb_name};
