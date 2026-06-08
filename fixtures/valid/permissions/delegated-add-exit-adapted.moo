":add_exit(OBJ exit) => INT";
"Called by exit setup helpers to add an exit using the caller's effective permissions.";
{exit} = args;
set_task_perms(caller_perms());
return `this.exits = setadd(this.exits, exit) ! E_PERM' != E_PERM;
