":store_map_value(STR key, MIXED value) => MAP";
"Called by dialect examples to demonstrate ToastStunt map syntax.";
{key, value} = args;
data = [];
data[key] = value;
return data;
