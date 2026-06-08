" bad:";
" if (!this.cache)";
"   this.cache = [];";
" endif";
" fixed:";
if (typeof(this.cache) != MAP)
  this.cache = [];
endif

return this.cache;
