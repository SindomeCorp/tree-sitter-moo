":verb_args_summary_4(OBJ object, STR verb_name) => STR|ERR";
"Called by code tools to summarize a verb argspec.";
{object, verb_name} = args;
spec = `verb_args(object, verb_name) ! E_VERBNF, E_PERM => E_VERBNF';
if (spec == E_VERBNF)
  return E_VERBNF;
endif
return tostr(spec[1], " ", spec[2], " ", spec[3]);
