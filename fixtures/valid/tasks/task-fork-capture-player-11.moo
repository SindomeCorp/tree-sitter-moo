":defer_notice_11(OBJ who, STR message, ?INT delay) => INT";
"Called by command verbs to send delayed feedback after revalidating the captured player.";
{who, message, ?delay = 11} = args;
fork (delay)
  if (valid(who))
    who:tell(message);
  endif
endfork
return 1;
