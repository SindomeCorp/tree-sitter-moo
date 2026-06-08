":read_optional_label(OBJ object) => ANY";
"Called by display helpers where a missing label has a default but permission errors should surface.";
{object} = args;
return `object.label ! E_PROPNF => "untitled"';
