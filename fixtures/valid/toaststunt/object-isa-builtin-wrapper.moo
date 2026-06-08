":isa(x,y) == is x a y / is obj a $player";
":isa(x,y) == valid(x) && (y==x || y in :ancestors(x))";
return isa(@args);
