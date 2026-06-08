":is_kind_of(OBJ object, OBJ parent) => INT";
"Called by matching helpers to test ancestry through a core utility verb.";
{object, parent} = args;
return $object_utils:isa(object, parent);
