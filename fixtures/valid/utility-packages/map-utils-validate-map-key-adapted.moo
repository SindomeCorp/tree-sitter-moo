":validate_map_key(MAP data, MIXED key, ?STR label, ?INT datatype, ?OBJ class) => none|ERR";
"Raise E_INVARG if data is not a map, key is absent, or the keyed value fails optional type/class checks.";
{data, key, ?label = "argument", ?datatype = -1, ?class = $nothing} = args;
if (typeof(data) != MAP)
  raise(E_INVARG, label + " must be a map");
elseif (!maphaskey(data, key))
  raise(E_INVARG, label + " must contain '" + tostr(key) + "'");
elseif (datatype >= 0 && typeof(data[key]) != datatype)
  raise(E_INVARG, label + "." + tostr(key) + " has the wrong type");
elseif ($recycler:valid(class) && !$object_utils:isa(data[key], class))
  raise(E_INVARG, tostr(label, ".", key, " must be a descendant of ", class));
endif
