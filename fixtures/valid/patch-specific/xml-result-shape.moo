":parse_xml_fragment(STR xml) => LIST|ERR";
"Called by integrations on cores that have the XML parsing patch installed.";
{xml} = args;
tree = `xml_parse_tree(xml) ! E_INVARG, E_TYPE';
return typeof(tree) == ERR ? tree | tree;
