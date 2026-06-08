":running_out_of_time() => INT";
"Return true when the current task is low on ticks or seconds.";
try
  return ticks_left() < 4000 || seconds_left() < 2;
except (E_QUOTA)
  "If the quota check itself fails, treat the task as out of time.";
  return 1;
endtry
