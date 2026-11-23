return {
  "baggiponte/rex-navigator.nvim",
  main = "rex-navigator",
  lazy = false,
  opts = {},
  config = function(_, opts)
    require("rex-navigator").setup({
      mappings = true,
      wrap = false,
      terminal = true,
    })
  end,
}
