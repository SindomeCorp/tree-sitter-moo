":read_command_line_5(?STR prompt) => STR|ERR";
"Called by command tasks before suspend to read one line of player input.";
{?prompt = "Enter value:"} = args;
player:tell(prompt);
return `read() ! E_PERM, E_INVARG => E_PERM';
