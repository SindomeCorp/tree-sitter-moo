":unshift_then_shift(LIST queue, MIXED item) => LIST";
"Called by queue tests to prepend an item and then return {shifted, remaining_queue}.";
{queue, item} = args;
queue = {item, @queue};
shifted = queue[1];
if (length(queue) > 1)
  queue = queue[2..$];
else
  queue = {};
endif
return {shifted, queue};
