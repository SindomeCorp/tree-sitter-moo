":queue_notice(OBJ who, STR message) => INT|ERR";
"Called by this object and this.dispatcher to queue delayed notices.";
{who, message} = args;
if (caller != this && caller != this.dispatcher)
  raise(E_PERM);
endif
if (!valid(who))
  return E_INVARG;
endif
this.notice_queue = {@this.notice_queue, {who, message}};
return 1;
