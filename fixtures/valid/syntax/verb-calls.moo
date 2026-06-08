name_text = this:name();
verb_name = "name";
computed_name = this:(verb_name)();
parts = {"prefix-", computed_name};
joined = tostr(@parts);
return {name_text, computed_name, joined};
