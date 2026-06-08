" bad:";
" // This may be accepted by ToastStunt source input, but it is not parsed as a MOO statement and will be dropped from stored verb code.";
" /* Block comments are not portable stored MOO comments either. */";
" \"This string comment is missing its terminating semicolon\"";
" fixed:";
" This is a proper MOO string-literal comment and remains in stored verb code.";
player:tell("Comment syntax repaired.");
