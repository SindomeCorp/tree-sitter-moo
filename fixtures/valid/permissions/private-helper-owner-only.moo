":private_set_label(OBJ object, STR value) => INT|ERR";
"Called only by same-object public wrappers after validating input shape.";
{object, value} = args;
if (!valid(object) || typeof(value) != STR)
  return E_INVARG;
endif
who = caller_perms();
if (!who.wizard && who != object.owner)
  return E_PERM;
endif
object.label = value;
return 1;
