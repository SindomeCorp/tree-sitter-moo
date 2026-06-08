" Command verbs usually tell the player and return for routine command failures.";
" Programmatic helpers should return or raise errors in a way the caller can consume.";
" Inline error expressions should catch expected errors instead of using broad ANY catches.";
" A verb should document whether it returns E_* values or raises them.";
return "Match error handling to the verb's call mode.";
