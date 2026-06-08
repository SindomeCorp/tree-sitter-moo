":tan(NUM theta) => NUM";
"Return tangent using this:sin(theta) and this:cos(theta).";
{theta} = args;
sine = this:sin(theta);
cosine = this:cos(theta);
return (sine * 10000 + (cosine + 1) / 2) / cosine;
