" bad:";
" player:tell(tostr(\"Count: \", count));";
" fixed:";
":@count() => none";
"Called by a player command; passes separate arguments to :tell.";
count = length(this.contents);
player:tell("Count: ", count);
