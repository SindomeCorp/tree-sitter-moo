" bad:";
" player:tell(\"You use \" + direct_object.name);";
" player:tell(\"Preposition: \" + prep);";
" fixed:";
if (valid(dobj))
  player:tell("You use " + dobj.name + ".");
else
  player:tell("You use " + dobjstr + ".");
endif

player:tell("Preposition: " + prepstr);
