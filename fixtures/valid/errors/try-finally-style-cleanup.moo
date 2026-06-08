":use_with_cleanup(OBJ target) => INT|ERR";
"Called by helpers that need to clear this.busy after a protected operation.";
{target} = args;
this.busy = 1;
try
  result = target:run();
except error (E_INVARG, E_PERM)
  this.busy = 0;
  return error[1];
endtry
this.busy = 0;
return result;
