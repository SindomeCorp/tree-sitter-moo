":fork_return_10(@MIXED values) => MIXED";
"called by syntax tests to demonstrate fork block syntax.";
{delay} = args;
fork (delay)
  this:after_delay();
endfork
return 1;
