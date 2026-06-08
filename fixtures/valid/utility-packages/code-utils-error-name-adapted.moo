":error_name(ERR error) => STR";
"Return the literal name of an error value, such as E_INVARG.";
{error} = args;
return toliteral(error);
