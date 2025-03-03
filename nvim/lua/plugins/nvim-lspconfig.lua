return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    keys[#keys + 1] = { "<c-k>", mode = { "i", "n" }, false }

    opts.diagnostics.update_in_insert = true
    opts.codelens.enabled = true
  end,
}
