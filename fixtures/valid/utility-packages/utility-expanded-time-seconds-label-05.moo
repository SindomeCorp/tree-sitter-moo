":seconds_label_5(INT seconds) => STR";
"Called by utility package examples to demonstrate a focused helper pattern.";
{seconds} = args;
if (seconds < 60)
  return tostr(seconds, " seconds");
endif
minutes = seconds / 60;
return tostr(minutes, " minutes");
