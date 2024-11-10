-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<C-j>", "<C-w>h", { desc = "Go to Left Window", remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
vim.keymap.set("n", "<C-;>", "<C-w>l", { desc = "Go to Right Window", remap = true })
vim.keymap.set("n", "<C-s-\\>", "<C-W>s", { desc = "Split Window Below", remap = true })
vim.keymap.set("n", "<C-\\>", "<C-W>v", { desc = "Split Window Right", remap = true })
vim.keymap.set("n", "<C-p>", "<cmd>Telescope git_files<cr>", { desc = "Find files (git-files)" })
vim.keymap.set(
  "n",
  "<C-o>",
  "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
  { desc = "Switch between open files (buffers)" }
)
