":rebuild_server_cache() => INT|ERR";
"Called by server maintenance code; only wizard-permission tasks may rebuild this cache.";
if (!caller_perms().wizard)
  raise(E_PERM);
endif
this.cache = this:build_cache();
this.cache_built_at = time();
return 1;
