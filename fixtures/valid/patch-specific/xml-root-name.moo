":xml_root_name(STR xml) => STR|ERR";
"Called by XML import helpers on cores that installed the XML parser patch.";
{xml} = args;
document = `xml_parse_document(xml) ! E_INVARG, E_TYPE => E_INVARG';
if (typeof(document) == ERR)
  return document;
endif
return document[1];
