":duration_format(INT seconds) => STR";
"Return the two largest human-readable units for a duration.";
{seconds} = args;
dhms = $time_utils:dhms(seconds);
dhms_tokens = $string_utils:explode(dhms, ":");
unit_names = {"day", "hour", "minute", "second"};
unit_names = unit_names[$ - length(dhms_tokens) + 1..$];
for index in [1..length(dhms_tokens)]
  value = toint(dhms_tokens[index]);
  plural = value > 1 || value < 1 ? "s" | "";
  dhms_tokens[index] = tostr(value, " ", unit_names[index], plural);
endfor
return $string_utils:english_list(dhms_tokens[1..min($, 2)]);
