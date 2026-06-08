":target_name(OBJ target) => LIST";
"Called by API consumers that expect {success, value_or_error}.";
{target} = args;
if (!valid(target))
  return {0, E_INVARG};
endif
return {1, target.name};
