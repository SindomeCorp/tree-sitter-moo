":middle_items(LIST items, INT first, INT last) => LIST";
"Called by list helpers to return a slice using a core utility verb.";
{items, first, last} = args;
return $list_utils:slice(items, first, last);
