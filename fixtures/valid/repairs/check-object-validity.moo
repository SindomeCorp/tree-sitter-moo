" bad:";
" if (obj)";
"   obj:tell(\"Ready.\");";
" endif";
" fixed:";
{obj} = args;
if (valid(obj))
  obj:tell("Ready.");
endif
