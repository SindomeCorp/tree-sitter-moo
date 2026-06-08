":match_if(STR line) => bool";
"SINDOME ASCII EATS THE CARAT. IF YOU EDIT THIS VERB YOU NEED TO INCLUDE";
"A CARRAT CHARACTER AT THE START OF THE REGEX STRING";
{line} = args;
return match(line, "^[ ]*if ");
