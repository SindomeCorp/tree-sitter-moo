":middle_items_fast(LIST items, INT first, INT last) => LIST";
"Called by ToastStunt-only helpers to return a slice using the server builtin.";
{items, first, last} = args;
return slice(items, first, last);
