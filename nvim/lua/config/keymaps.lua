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
