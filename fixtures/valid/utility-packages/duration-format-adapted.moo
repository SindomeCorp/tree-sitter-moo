":duration_format(INT seconds) => STR";
"Called by display helpers to summarize a duration using the two largest units.";
{seconds} = args;
dhms = $time_utils:dhms(seconds);
tokens = $string_utils:explode(dhms, ":");
units = {"day", "hour", "minute", "second"};
units = units[$ - length(tokens) + 1..$];
for i in [1..length(tokens)]
  value = toint(tokens[i]);
  tokens[i] = tostr(value, " ", units[i], value == 1 ? "" | "s");
endfor
return $string_utils:english_list(tokens[1..min($, 2)]);
