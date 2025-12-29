-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap
-- local map = LazyVim.safe_keymap_set

keymap.set("i", "<C-h>", "<Left>")
keymap.set("i", "<C-l>", "<Right>")
keymap.set("i", "<C-k>", "<Up>")
keymap.set("i", "<C-j>", "<Down>")
keymap.set("c", "<C-h>", "<Left>")
keymap.set("c", "<C-l>", "<Right>")
keymap.set("c", "<C-k>", "<Up>")
keymap.set("c", "<C-j>", "<Down>")

-- resize window height
keymap.set("n", "<D-Up>", "<cmd>resize +2<cr>")
keymap.set("n", "<D-Down>", "<cmd>resize -2<cr>")

-- remove marks
keymap.set("n", "<leader>md", function()
  vim.cmd("delmarks " .. vim.fn.nr2char(vim.fn.getchar()))
end, { desc = "Remove mark" })

keymap.set("n", "<leader>ma", "<cmd>delmarks A-Za-z0-9<cr>", { desc = "Delete all marks" })

-- Clear output in iex including scrollback
keymap.set("n", "<leader>``", function()
  local sb = vim.bo.scrollback
  vim.bo.scrollback = 1
  vim.fn.chansend(vim.bo.channel, { "clear\r\n" })
  vim.bo.scrollback = sb
  -- vim.fn.chansend(vim.bo.channel, vim.api.nvim_replace_termcodes("clear()\r\n", true, true, true))
end)

-- Window management
keymap.set("n", "<C-w>S", "<cmd>WinShift<CR>", { desc = "Enter WinShift mode" })

local wk = require("which-key")

local function new_note()
  local filename = vim.fn.input("New note name: ")
  filename = string.gsub(filename, "<", "")
  vim.cmd("ObsidianNew " .. filename .. "<cr>")
  print("Note " .. filename .. " created successfully")
end
wk.add({
  { "<leader>o", group = "Obsidian" },
  { "<leader>on", new_note, desc = "Create new note", mode = "n" },
  { "<leader>ot", "<cmd>ObsidianTags<CR>", desc = "List tag", mode = "n" },
  { "<leader>oo", "<cmd>ObsidianQuickSwitch<CR>", desc = "List notes", mode = "n" },
  { "<leader>ow", "<cmd>ObsidianWorkspace<CR>", desc = "List workspaces", mode = "n" },
  { "<leader>oo", "<cmd>ObsidianSearch<CR>", desc = "Search all notes", mode = "n" },
})

-- Copilot and Copilot CHat
-- Reference: https://github.com/CopilotC-Nvim/CopilotChat.nvim?tab=readme-ov-file#chat-key-mappings
vim.g.copilot_no_tab_map = false
vim.keymap.set("i", "<S-Tab>", 'copilot#Accept("\\<S-Tab>")', { expr = true, replace_keycodes = false })
-- Obsidian
-- keymap.set("n", "<leader>ot", "<cmd>ObsidianTags<CR>", { desc = " List tags", group = "Obsidian" })
-- keymap.set("n", "<leader>ot", "<cmd>ObsidianQuickSwitch<CR>", { desc = "List notes" })
-- keymap.set("n", "<leader>ow", "<cmd>ObsidianWorkspace<CR>", { desc = "List workspaces" })
-- keymap.set("n", "<leader>os", "<cmd>ObsidianSearch<CR>", { desc = "Search in all notes" })

vim.keymap.set("i", "<C-L>", "<Plug>(copilot-accept-word)")

--# Venn.nvim keymap
-- toggle keymappings for venn using <leader>v
vim.api.nvim_set_keymap("n", "<leader>v", ":lua Toggle_venn()<CR>", { noremap = true })
