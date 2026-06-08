":add_member(OBJ member) => INT";
"Called by setup verbs to add an object to this.members using the caller's effective permissions.";
set_task_perms(caller_perms());
return `this.members = setadd(this.members, args[1]) ! E_PERM' != E_PERM;
