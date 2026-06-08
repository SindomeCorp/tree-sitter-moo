":match_comment(STR line) => INT";
"Called by code scanners to detect MOO string-literal comments.";
{line} = args;
return match(line, "^[ ]*\"");
