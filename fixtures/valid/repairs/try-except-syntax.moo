" bad:";
" try {";
"   value = toint(args[1]);";
" } catch (E_INVARG) {";
"   value = 0;";
" }";
" fixed:";
try
  value = toint(args[1]);
except (E_INVARG, E_TYPE)
  value = 0;
endtry

return value;
