{xml} = args;
if (typeof(xml) != STR || !xml)
  raise(E_INVARG, "xml must be a non-empty string");
endif

return xml_parse_document(xml);
