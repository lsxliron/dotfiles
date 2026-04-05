return {
  "christoomey/vim-tmux-navigator",
  init = function()
    vim.g.tmux_navigator_no_mappings = 1
  end,
  config = function()
    local map = vim.keymap.set
    local opts = { silent = true }

    -- Normal mode (tmux-aware)
    map("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", opts)
    map("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", opts)
    map("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", opts)
    map("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", opts)

    -- Terminal mode (escape terminal first, then tmux-aware nav)
    map("t", "<C-h>", [[<C-\><C-n><cmd>TmuxNavigateLeft<CR>]], opts)
    map("t", "<C-j>", [[<C-\><C-n><cmd>TmuxNavigateDown<CR>]], opts)
    map("t", "<C-k>", [[<C-\><C-n><cmd>TmuxNavigateUp<CR>]], opts)
    map("t", "<C-l>", [[<C-\><C-n><cmd>TmuxNavigateRight<CR>]], opts)
  end,
}
