":dotkey(MAP value, STR key_path) => MIXED";
"Read nested string keys from a map using dot notation, such as `profile.name.first`.";
{value, key_path} = args;
if (typeof(value) != MAP)
  raise(E_INVARG, "value is not a map");
elseif (typeof(key_path) != STR)
  raise(E_INVARG, "key_path is not a string");
elseif (!key_path)
  raise(E_INVARG, "key_path cannot be empty");
endif
current = value;
for key in (explode(key_path, "."))
  current = current[key[1] == "#" ? toobj(key) | key];
endfor
return current;
