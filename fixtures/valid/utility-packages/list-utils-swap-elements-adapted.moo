":swap_elements(LIST values, INT left_index, INT right_index) => LIST|ERR";
"Called by ordering helpers to exchange two list elements.";
{values, left_index, right_index} = args;
if (typeof(values) != LIST || typeof(left_index) != INT || typeof(right_index) != INT)
  return E_TYPE;
endif
limit = length(values);
if (left_index < 1 || left_index > limit || right_index < 1 || right_index > limit)
  return E_RANGE;
endif
temporary = values[left_index];
values[left_index] = values[right_index];
values[right_index] = temporary;
return values;
