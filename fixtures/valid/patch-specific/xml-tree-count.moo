":xml_tree_child_count(STR xml) => INT|ERR";
"Called by XML import helpers to count top-level child nodes.";
{xml} = args;
tree = `xml_parse_tree(xml) ! E_INVARG, E_TYPE => E_INVARG';
if (typeof(tree) == ERR)
  return tree;
endif
return length(tree);
