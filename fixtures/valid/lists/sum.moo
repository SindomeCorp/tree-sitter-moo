":sum(LIST numbers) => total of all elements in `numbers' added together";
total = 0;
for number in (typeof(x = args[1]) == LIST ? x | args)
  total = total + number;
endfor
return total;
