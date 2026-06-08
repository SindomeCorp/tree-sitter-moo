local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

parser_config.moo = {
  install_info = {
    url = "https://github.com/SindomeCorp/tree-sitter-moo",
    files = { "src/parser.c" },
    branch = "main",
  },
  filetype = "moo",
}

vim.filetype.add({
  extension = {
    moo = "moo",
  },
})
