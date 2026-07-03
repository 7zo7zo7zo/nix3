local map = vim.keymap.set

-- Buffer: like browser tabs (Tab = next, S-Tab = prev)
map("n", "<Tab>", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<S-Tab>", ":bprevious<CR>", { desc = "Previous buffer" })

-- Buffer: arrow keys (S-h = left, S-l = right)
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>x", "<cmd>bd<cr>", { desc = "Close Buffer" })

-- Open Nnn Picker
map("n", "<leader>e", "<cmd>NnnPicker<CR>")
map("t", "<leader>e", "<cmd>NnnPicker<CR>")
