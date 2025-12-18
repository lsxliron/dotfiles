return {
  "nvim-telescope/telescope.nvim",
  tag = "v0.1.9",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = function(_, opts)
    local actions = require("telescope.actions")
    if not opts.defaults then
      opts.defaults = {}
    end

    if not opts.defaults.mappings then
      opts.defaults.mappings = {}
    end

    if not opts.defaults.mappings.i then
      opts.defaults.mappings.i = {}
    end

    opts.defaults.mappings.i["<C-j>"] = actions.move_selection_next
    opts.defaults.mappings.i["<C-k>"] = actions.move_selection_previous

    -- Disable treesitter-based previewer if needed
    -- opts.defaults.preview = { treesitter = false }
  end,
}
