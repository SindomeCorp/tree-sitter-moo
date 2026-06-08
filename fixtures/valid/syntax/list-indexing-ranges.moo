items = {"north", "south", "east", "west"};
first = items[1];
middle = items[2..3];
items[4] = "down";
return {first, middle, items};
