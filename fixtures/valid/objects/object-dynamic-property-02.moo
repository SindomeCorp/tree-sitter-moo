":read_named_property_2(OBJ object, STR prop, MIXED fallback) => MIXED";
"Called by generic display helpers to read a dynamic property with fallback.";
{object, prop, fallback} = args;
return `object.(prop) ! E_PROPNF, E_PERM => fallback';
