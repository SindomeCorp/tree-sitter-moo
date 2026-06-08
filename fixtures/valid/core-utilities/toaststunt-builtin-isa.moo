":is_kind_of_fast(OBJ object, OBJ parent) => INT";
"Called by ToastStunt-only helpers to test ancestry using the server builtin.";
{object, parent} = args;
return isa(object, parent);
