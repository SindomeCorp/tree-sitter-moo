":trim(STR string, ?STR space) => STR";
"Remove leading and trailing copies of space, which defaults to a single space.";
{string, ?space = " "} = args;
match_range = match(string, tostr("[^", space, "]%(.*[^", space, "]%)?%|$"));
return string[match_range[1]..match_range[2]];
