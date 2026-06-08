":scatter_rest_1(@MIXED values) => MIXED";
"called by syntax tests to collect required and rest args.";
{first, @rest} = args;
return {first, rest};
