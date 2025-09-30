return {
  "neovim/nvim-lspconfig",
  opts = function(opts)
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    keys[#keys + 1] = { "<c-k>", mode = { "i", "n" }, false }
  end,
}
