values = {"alpha", "beta", "gamma", "delta"};
{first, ?second = "fallback", @rest} = values;
return {first, second, rest};
