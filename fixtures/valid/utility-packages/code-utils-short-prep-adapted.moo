":short_prep(STR preposition) => STR";
"Return the shortest preposition equivalent to preposition, or an empty string if none is known.";
{preposition} = args;
if (server_version() != this._version)
  this:_fix_preps();
endif
word = preposition[1..index(preposition + "/", "/") - 1];
position = word in this._other_preps;
if (position)
  return this._short_preps[this._other_preps_n[position]];
elseif (word in this._short_preps)
  return word;
else
  return "";
endif
