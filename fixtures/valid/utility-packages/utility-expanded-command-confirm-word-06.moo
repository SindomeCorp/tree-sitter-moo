":confirm_word_6(STR answer) => INT|ERR";
"Called by utility package examples to demonstrate a focused helper pattern.";
{answer} = args;
answer = $string_utils:trim(answer);
if (index("yes", answer) == 1)
  return 1;
elseif (index("no", answer) == 1)
  return 0;
endif
return E_INVARG;
