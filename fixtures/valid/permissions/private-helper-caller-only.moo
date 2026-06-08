":record_internal(MIXED value) => INT|ERR";
"Called only by other verbs on this object to append an internal value.";
{value} = args;
if (caller != this)
  return E_PERM;
endif
this.internal_values = {@this.internal_values, value};
return 1;
