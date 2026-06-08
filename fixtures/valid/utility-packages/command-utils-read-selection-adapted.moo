":read_selection(LIST items, ?STR prompt) => INT";
"Read a numeric selection and return the selected index, or 0 if the input is invalid.";
{items, ?prompt = "a number"} = args;
selection = `toint($command_utils:read(prompt)) ! E_INVARG, E_TYPE => 0';
if (!selection || !`typeof(items[selection]) != ERR ! E_RANGE => 0')
  return 0;
endif
return selection;
