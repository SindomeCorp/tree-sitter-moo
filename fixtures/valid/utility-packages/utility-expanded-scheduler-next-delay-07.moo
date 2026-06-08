":next_delay_7(INT when) => INT";
"Called by utility package examples to demonstrate a focused helper pattern.";
{when} = args;
return max(0, when - time());
