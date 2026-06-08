":queue_private_notice(OBJ who, STR message) => INT";
"Called only by this object or this.dispatcher to queue a deferred notice.";
if (caller != this && caller != this.dispatcher)
  raise(E_PERM);
endif
{who, message} = args;
this.notice_queue = {@this.notice_queue, {who, message}};
return 1;
