" bad:";
" text = $su:trim(text);";
" $cu:suspend_if_needed(0);";
" fixed:";
{text} = args;
text = $string_utils:trim(text);
$command_utils:suspend_if_needed(0);
return text;
