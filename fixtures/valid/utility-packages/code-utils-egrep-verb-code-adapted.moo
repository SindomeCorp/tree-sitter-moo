":egrep_verb_code(STR pattern, OBJ object, STR verb_name, ?INT case_matters) => LIST|ERR";
"Return lines in object:verb_name whose source matches pattern.";
set_task_perms(caller_perms());
{pattern, object, verb_name, ?case_matters = 0} = args;
code = `verb_code(object, verb_name) ! E_VERBNF, E_PERM => E_PERM';
if (code == E_PERM)
  return E_PERM;
endif
matches = {};
for line in (code)
  try
    if (match(line, pattern, case_matters))
      matches = {@matches, line};
    endif
  except (E_INVARG)
    return E_INVARG;
  endtry
endfor
return matches;
