":starts_with(STR text, STR prefix, ?INT case_matters) => INT";
"Return 1 when text starts with prefix; case only matters when case_matters is true.";
{text, prefix, ?case_matters = 0} = args;
return index(text, prefix, case_matters) == 1;
