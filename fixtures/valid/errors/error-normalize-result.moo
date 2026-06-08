":read_property_result(OBJ object, STR property) => LIST";
"Called by APIs that need structured result rows for dynamic property reads.";
{object, property} = args;
if (!valid(object) || typeof(property) != STR)
  return {0, E_INVARG};
endif
value = `object.(property) ! E_PROPNF => E_PROPNF';
if (value == E_PROPNF)
  return {0, E_PROPNF};
endif
return {1, value};
