":scatter_optional_2(@MIXED values) => MIXED";
"called by syntax tests to demonstrate optional scatter defaults.";
{value, ?fallback = 0} = args;
return value || fallback;
