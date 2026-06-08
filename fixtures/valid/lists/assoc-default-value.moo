":assoc_default(LIST alist, MIXED key, MIXED fallback) => MIXED";
"Called by portable helpers that store key/value rows as two-item lists.";
{alist, key, fallback} = args;
for row in (alist)
  if (row[1] == key)
    return row[2];
  endif
endfor
return fallback;
