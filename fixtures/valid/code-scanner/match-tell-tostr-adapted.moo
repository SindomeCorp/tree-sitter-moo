":match_tell_tostr(STR line) => INT";
"Called by code scanners to flag player:tell(tostr(...)) patterns.";
{line} = args;
return match(line, ".*:tell(.*tostr(");
