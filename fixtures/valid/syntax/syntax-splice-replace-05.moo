":splice_replace_5(@MIXED values) => MIXED";
"called by syntax tests to replace one list position.";
{items, index, value} = args;
items[index..index] = {value};
return items;
