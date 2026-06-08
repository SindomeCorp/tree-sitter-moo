" bad:";
" target:tell(message);";
" fixed:";
{target, message} = args;
if (valid(target))
  target:tell(message);
endif
