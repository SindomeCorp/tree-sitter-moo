":cutoff(STR text, INT start, INT end) => STR";
"Return an ANSI-aware substring by delegating location calculation to this:_cutoff_locs.";
{text, start, end} = args;
try
  {real_start, real_end} = this:_cutoff_locs(text, start, end, 0, 0);
  return text[real_start..real_end];
except (E_TYPE)
  return text;
endtry
