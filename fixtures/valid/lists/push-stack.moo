":push(ANY item, LIST stack) => LIST newstack";
"Adds the item to the end of the stack and return the new stack.";
{item, stack} = args;
return {@stack, item};
