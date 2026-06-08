" bad:";
" subset = slice(items, 2, 4);";
" ordered = sort(items);";
" fixed:";
{items} = args;
subset = $list_utils:slice(items, 2, 4);
ordered = $list_utils:sort(items);
return {subset, ordered};
