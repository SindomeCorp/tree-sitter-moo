" bad:";
" {types, ?filter = \"\"} = args;";
" return filter ? $list_utils:assoc(filter, types) | types;";
" fixed:";
":filter_types(LIST types, ?STR filter) => LIST";
"Called by search helpers to optionally narrow a list of type rows by filter.";
{types, ?filter = ""} = args;
return filter ? $list_utils:assoc(filter, types) | types;
