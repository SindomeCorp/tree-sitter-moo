":set_name(@MIXED arguments) => MIXED";
"Called by wrapper APIs to delegate inherited name-setting behavior under the caller's effective permissions.";
set_task_perms(caller_perms());
result = pass(@args);
return result;
