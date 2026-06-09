if ready
  player:tell("ready");
endif

count = max(1, 2.5);
sys = $server();
total = $math:max(count, sys);
kind = INT;
err = E_INVARG;
obj = #12;
parts = {"prefix", count};
value = obj.name;
tags = ["name" -> value];
