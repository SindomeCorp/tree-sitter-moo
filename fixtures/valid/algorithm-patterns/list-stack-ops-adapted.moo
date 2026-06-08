":push_then_pop(LIST stack, MIXED item) => LIST";
"Called by stack tests to append an item and then return {popped, remaining_stack}.";
{stack, item} = args;
stack = {@stack, item};
popped = stack[$];
if (length(stack) > 1)
  stack = stack[1..$ - 1];
else
  stack = {};
endif
return {popped, stack};
