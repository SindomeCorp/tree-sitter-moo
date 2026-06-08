" bad:";
" value = args[2];";
" player:tell(value);";
" fixed:";
if (length(args) >= 2)
  value = args[2];
else
  value = "";
endif

player:tell(tostr(value));
