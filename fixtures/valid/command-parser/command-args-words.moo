if (!args)
  player:tell("Usage: tag <word> [word...]");
  return;
endif

for word in (args)
  player:tell("Tag: " + word);
endfor
