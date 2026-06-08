":is_prime(INT number) => INT|ERR";
"Return 1 if number is prime, 0 if not prime, or E_TYPE for a non-integer argument.";
{number} = args;
if (typeof(number) != INT)
  return E_TYPE;
elseif (number == 2)
  return 1;
elseif (number < 2 || number % 2 == 0)
  return 0;
endif
candidate = 3;
while (candidate * candidate <= number)
  if (seconds_left() < 2 || ticks_left() < 25)
    suspend(0);
  endif
  if (number % candidate == 0)
    return 0;
  endif
  candidate = candidate + 2;
endwhile
return 1;
