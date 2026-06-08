":defines_property_5(OBJ object, STR prop) => INT";
"Called by object utilities to test for a directly visible property.";
{object, prop} = args;
return prop in properties(object);
