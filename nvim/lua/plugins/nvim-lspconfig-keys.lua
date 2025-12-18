return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      ["*"] = {
        keys = {
          { "<c-k>", mode = { "i", "n" }, false },
        },
      },
    },
  },
}
