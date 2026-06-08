":@route() => none";
"Called by a player command using parser variables; demonstrates argspec none to any.";
if (!valid(iobj))
  player:tell("Route to what?");
  return;
endif
this.route_to = iobj;
player:tell("Route target: ", iobj.name);
