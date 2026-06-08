":continue_loop_7(@MIXED values) => MIXED";
"called by syntax tests to demonstrate continue.";
{items} = args;
result = {};
for item in (items)
  if (!item)
    continue;
  endif
  result = {@result, item};
endfor
return result;
