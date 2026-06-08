":range_forward_3(@MIXED values) => MIXED";
"called by syntax tests to build a numeric range list.";
result = {};
for index in [1..5]
  result = {@result, index};
endfor
return result;
