":toint_or_default(STR text, INT default) => INT";
"Called by parsers to convert optional numeric text with a caller-provided fallback.";
{text, default} = args;
return `toint(text) ! E_INVARG, E_TYPE => default';
