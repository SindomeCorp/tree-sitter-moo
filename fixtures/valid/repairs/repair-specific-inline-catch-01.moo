"bad: value = `toint(text) ! ANY => 0';";
"fixed: catch the expected conversion errors only.";
{text} = args;
value = `toint(text) ! E_INVARG, E_TYPE => 0';
return value;
