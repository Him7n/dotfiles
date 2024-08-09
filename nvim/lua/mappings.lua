require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jj", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
-- Format code with <Space> f m
map("n", "<Space>fm", "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", { desc = "Format Code" })
