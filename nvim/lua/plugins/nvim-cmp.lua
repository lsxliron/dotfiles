return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local cmp = require("cmp")
    opts.mapping = cmp.mapping.preset.insert({
      ["<C-j>"] = cmp.mapping.select_next_item(),
      ["<C-k>"] = cmp.mapping.select_prev_item(),
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<Tab>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ["<C-e>"] = cmp.mapping.close(),
    })

    -- Disable in comments
    opts.enabled = function()
      local context = require("cmp.config.context")
      if vim.api.nvim_get_mode().mode == "c" then
        return true
      else
        return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
      end
    end
  end,
}
