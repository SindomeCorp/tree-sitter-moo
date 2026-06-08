if (typeof(this.cache) != MAP)
  this.cache = [];
endif

key = args[1];
if (!maphaskey(this.cache, key))
  this.cache[key] = this:compute_value(key);
endif

return this.cache[key];
