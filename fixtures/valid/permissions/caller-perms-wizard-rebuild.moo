":rebuild_cache() => INT|ERR";
"Called by administrative maintenance verbs to rebuild this.cache; returns E_PERM unless the calling verb runs with wizard permissions.";
if (!caller_perms().wizard)
  return E_PERM;
endif
this.cache = this:build_cache();
return 1;
