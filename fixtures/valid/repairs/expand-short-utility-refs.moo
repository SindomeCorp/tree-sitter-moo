" bad:";
" row = $lu:assoc(key, rows);";
" ok = $ou:has_verb(obj, \"look\");";
" fixed:";
{key, rows, obj} = args;
row = $list_utils:assoc(key, rows);
ok = $object_utils:has_verb(obj, "look");
return {row, ok};
