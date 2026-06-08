":make_repeated(INT count, ?MIXED value) => LIST|ERR";
"Called by list utilities to create count copies of value.";
{count, ?value = 0} = args;
if (count < 0)
  return E_INVARG;
endif
result = {};
build = {value};
while (1)
  if (count % 2)
    result = {@result, @build};
  endif
  count = count / 2;
  if (count)
    build = {@build, @build};
  else
    return result;
  endif
endwhile
