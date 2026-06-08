" Owner checks are appropriate for player-facing command policy.";
" Programmatic helpers should usually use caller_perms() or a permission helper.";
" player is not the authority for a task that was called by another verb.";
" caller identifies the verb object that invoked the current verb.";
return "Prefer caller_perms() for programmatic authority.";
