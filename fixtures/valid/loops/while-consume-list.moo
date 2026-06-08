":consume_queue(LIST queue) => LIST";
"Called by loop examples to process a queue until it is empty.";
{queue} = args;
processed = {};
while (queue)
  current = queue[1];
  queue = listdelete(queue, 1);
  processed = {@processed, current};
endwhile
return processed;
