":argspec_readable(OBJ object, STR name) => STR|ERR";
"Called by documentation generators to summarize a command verb argspec.";
{object, name} = args;
spec = `verb_args(object, name) ! E_VERBNF, E_PERM => E_VERBNF';
if (spec == E_VERBNF)
  return spec;
endif
return tostr(spec[1], " ", spec[2], " ", spec[3]);
