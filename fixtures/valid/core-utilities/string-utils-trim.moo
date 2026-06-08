":normalized_name(STR text) => STR";
"Called by parsing helpers to trim input text with a core utility verb.";
{text} = args;
return $string_utils:trim(text);
