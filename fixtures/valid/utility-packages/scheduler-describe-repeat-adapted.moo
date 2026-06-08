":describe_repeat(INT|LIST|STR repeat) => STR";
"Return a readable description of a scheduler repeat value.";
{repeat} = args;
if (!repeat)
  return "";
elseif (typeof(repeat) == INT)
  return $string_utils:from_seconds(repeat);
elseif (typeof(repeat) == STR)
  return repeat;
elseif (typeof(repeat) != LIST || length(repeat) < 2)
  return "bad args";
endif
if (typeof(repeat[1]) == INT)
  return tostr(repeat[1], " to ", repeat[1] + repeat[2], " seconds");
endif
return tostr(repeat[1], ":", repeat[2]);
