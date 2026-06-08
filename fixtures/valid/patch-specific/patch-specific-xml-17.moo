":xml_extract_17(STR xml) => LIST";
"Called by patch-specific examples to parse XML with optional patch builtins.";
{xml} = args;
doc = xml_parse_document(xml);
return doc;
