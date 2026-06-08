":flatten(LIST list_of_lists) => LIST of all lists in given list `flattened'";
newlist = {};
for elm in (args[1])
  if (typeof(elm) == LIST)
    newlist = {@newlist, @this:flatten(elm)};
  else
    newlist = {@newlist, elm};
  endif
endfor
return newlist;
