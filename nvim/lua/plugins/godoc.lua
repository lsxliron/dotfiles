return {
  "fredrikaverpil/godoc.nvim",
  version = "*",
  dependencies = {
    { "nvim-telescope/telescope.nvim" }, -- optional
    { "folke/snacks.nvim" }, -- optional
    { "nvim-mini/mini.pick" }, -- optional
    { "ibhagwan/fzf-lua" }, -- optional
  },
  build = "go install github.com/lotusirous/gostdsym/stdsym@latest", -- optional
  config = function()
    require("godoc").setup({
      adapters = {
        {
          name = "go",
          opts = {
            command = "GoDoc", -- the vim command to invoke Go documentation
            get_syntax_info = function()
              return {
                filetype = "godoc", -- filetype of the documentation buffer
                language = "", -- tree-sitter parser, for syntax highlighting
              }
            end,
          },
        },
      },
      window = {
        type = "split", -- split | vsplit
      },
      picker = {
        type = "telescope", -- native (vim.ui.select) | telescope | snacks | mini | fzf_lua

        -- per-picker options (see lua/godoc/pickers/<name>.lua for available fields)
        -- native = {},
        -- telescope = {},
        -- snacks = {},
        -- mini = {},
        -- fzf_lua = {},
      },
    })
  end,
}
