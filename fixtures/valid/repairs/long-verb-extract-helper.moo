" bad:";
" A command verb parses input, validates permissions, mutates state, formats output, and sends notifications in one long body.";
" fixed:";
":format_status_line(OBJ who, LIST stats) => STR";
"Called by larger commands after parsing and validation have already happened.";
{who, stats} = args;
return tostr(who.name, ": ", toliteral(stats));
