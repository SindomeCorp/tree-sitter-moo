":bool_result_3(MIXED value) => BOOL";
"Called by ToastStunt examples to return a true BOOL value.";
{value} = args;
if (typeof(value) == BOOL)
  return value;
endif
return value ? true | false;
