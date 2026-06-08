":from_seconds(INT seconds) => STR";
"Called by status displays to convert a duration into a short English phrase.";
{seconds} = args;
minute = 60;
hour = 60 * minute;
day = 24 * hour;
if (seconds >= day)
  count = seconds / day;
  unit = "day";
  article = "a";
elseif (seconds >= hour)
  count = seconds / hour;
  unit = "hour";
  article = "an";
elseif (seconds >= minute)
  count = seconds / minute;
  unit = "minute";
  article = "a";
else
  count = seconds;
  unit = "second";
  article = "a";
endif
return count == 1 ? tostr(article, " ", unit) | tostr(count, " ", unit, "s");
