":unshorten_direction(STR direction) => STR";
"Return the long form of a common direction abbreviation, or direction if it is not abbreviated.";
{direction} = args;
directions = {{"s", "south"}, {"n", "north"}, {"e", "east"}, {"w", "west"}, {"ne", "northeast"}, {"se", "southeast"}, {"sw", "southwest"}, {"nw", "northwest"}, {"u", "up"}, {"d", "down"}};
row = $list_utils:assoc(direction, directions);
return row ? row[2] | direction;
