return {
  "neovim/nvim-lspconfig",
  opts = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    keys[#keys + 1] = { "<c-k>", mode = { "i", "n" }, false }
  end,
  -- opts = {
  --   servers = {
  --     pyright = {},
  --     elixirls = {
  --       cmd = { "/Users/lsxliron/.local/share/nvim/mason/bin/elixir-ls" },
  --       filetypes = { "elixir", "eelixir", "heex", "surface" },
  --     },
  --     tailwindcss = {},
  --     cssls = {},
  --     vtsls = {},
  --     lua_ls = {},
  --   },
  -- },
}
