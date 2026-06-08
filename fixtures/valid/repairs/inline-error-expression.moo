" bad:";
" value = `toint(args[1]) ! E_INVARG, E_TYPE => 0;";
" value = try toint(args[1]) catch E_INVARG return 0;";
" fixed:";
value = `toint(args[1]) ! E_INVARG, E_TYPE => 0';
return value;
