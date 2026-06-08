":to_seconds(STR clock) => INT|ERR";
"Return the number of seconds elapsed since midnight for an hh:mm:ss string.";
{clock} = args;
if (typeof(clock) != STR || length(clock) < 8)
  return E_INVARG;
endif
hours = `toint(clock[1..2]) ! E_INVARG, E_TYPE => E_INVARG';
minutes = `toint(clock[4..5]) ! E_INVARG, E_TYPE => E_INVARG';
seconds = `toint(clock[7..8]) ! E_INVARG, E_TYPE => E_INVARG';
if (hours == E_INVARG || minutes == E_INVARG || seconds == E_INVARG)
  return E_INVARG;
endif
return 3600 * hours + 60 * minutes + seconds;
