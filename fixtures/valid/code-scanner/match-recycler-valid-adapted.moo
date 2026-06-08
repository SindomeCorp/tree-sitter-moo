":match_recycler_valid(STR line) => INT";
"Called by code scanners to flag guard clauses that may need !$recycler:valid(...).";
{line} = args;
return match(line, "^[ ]*if (%$recycler:valid");
