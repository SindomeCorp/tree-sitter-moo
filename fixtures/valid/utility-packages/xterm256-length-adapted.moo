":length(MIXED ...) => INT";
"Return visible length of text after removing xterm color tags.";
return length(this:strip_tags(tostr(@args)));
