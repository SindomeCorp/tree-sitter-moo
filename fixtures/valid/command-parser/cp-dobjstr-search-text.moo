"Command body for `search any none none`.";
"Uses dobjstr because the command searches text, not necessarily a matched object.";
if (!length(dobjstr))
  player:tell("Search for what?");
  return;
endif
results = this:search_text(dobjstr);
player:tell("Found ", length(results), " result", length(results) == 1 ? "." | "s.");
