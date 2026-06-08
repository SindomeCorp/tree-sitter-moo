try
  label = this.missing_property_for_syntax_example;
except (E_PROPNF)
  label = "missing";
endtry
return label;
