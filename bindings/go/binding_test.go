package tree_sitter_moo_test

import (
	"strings"
	"testing"

	tree_sitter "github.com/tree-sitter/go-tree-sitter"
	tree_sitter_moo "github.com/SindomeCorp/tree-sitter-moo"
)

func TestCanLoadGrammar(t *testing.T) {
	language := tree_sitter.NewLanguage(tree_sitter_moo.Language())
	if language == nil {
		t.Errorf("Error loading Moo grammar")
	}
}

func TestCanParseSampleMoo(t *testing.T) {
	language := tree_sitter.NewLanguage(tree_sitter_moo.Language())
	parser := tree_sitter.NewParser()
	if err := parser.SetLanguage(language); err != nil {
		t.Fatalf("Error loading Moo grammar: %v", err)
	}

	tree := parser.Parse([]byte("player:tell(\"Hello from MOO.\");\nif ready\n  return [1..$];\nendif\n"), nil)
	if tree == nil {
		t.Fatal("Expected sample MOO parse to return a tree")
	}
	root := tree.RootNode()

	if root.HasError() {
		t.Fatalf("Expected sample MOO to parse without errors, got %s", root.ToSexp())
	}

	for _, nodeType := range []string{"verb_call", "if_statement", "range_literal"} {
		if !strings.Contains(root.ToSexp(), nodeType) {
			t.Fatalf("Expected parse tree to include %s, got %s", nodeType, root.ToSexp())
		}
	}
}
