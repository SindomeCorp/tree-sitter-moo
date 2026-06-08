{message, ?delay = 5} = args;
who = player;

fork (delay)
  if (valid(who))
    who:tell(message);
  endif
endfork

return "Reminder scheduled.";
