":round(FLOAT number, ?INT mode) => FLOAT";
"Round number according to mode: 1 rounds 5-9 up, 2 rounds 6-9 up, 3 rounds odd first decimals up.";
{number, ?mode = 1} = args;
rounded = tofloat(toint(number));
decimal = toint((number - rounded) * 10.0);
if (mode == 1)
  rounded = decimal > 4 ? rounded + 1.0 | rounded;
elseif (mode == 2)
  rounded = decimal > 5 ? rounded + 1.0 | rounded;
elseif (mode == 3)
  rounded = decimal % 2 ? rounded + 1.0 | rounded;
endif
return rounded;
