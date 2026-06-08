":is_configured(OBJ object) => BOOL";
"Called by ToastStunt-only APIs that expect a true BOOL result.";
{object} = args;
if (!valid(object))
  return false;
endif
configured = `object.configured ! E_PROPNF => false';
if (typeof(configured) == BOOL)
  return configured;
endif
return configured ? true | false;
