local parsers = require("nvim-treesitter.parsers")
local parser_config = parsers.get_parser_configs and parsers.get_parser_configs() or parsers

parser_config.moo = {
  install_info = {
    url = "https://github.com/SindomeCorp/tree-sitter-moo",
    files = { "src/parser.c" },
    branch = "main",
    queries = "queries/moo",
  },
  filetype = "moo",
}

vim.filetype.add({
  extension = {
    moo = "moo",
  },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "moo",
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
