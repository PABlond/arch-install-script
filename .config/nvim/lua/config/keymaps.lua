-- Raccourcis clavier globaux
-- Fichier: ~/.config/nvim/lua/config/keymaps.lua

-- Explorateur de fichiers
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true, desc = "Toggle NvimTree" })

-- Telescope
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { noremap = true, silent = true, desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", { noremap = true, silent = true, desc = "Live Grep" })
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", { noremap = true, silent = true, desc = "Find Buffers" })
vim.keymap.set("n", "<leader>gs", ":Telescope git_status<CR>", { noremap = true, silent = true, desc = "Git Status" })
vim.keymap.set("n", "<leader>gh", ":Telescope git_commits<CR>", { noremap = true, silent = true, desc = "Git Commits" })
vim.keymap.set("n", "<leader>gb", ":Telescope git_branches<CR>", { noremap = true, silent = true, desc = "Git Branches" })
vim.api.nvim_set_keymap('n', '<leader>b', ':Telescope current_buffer_fuzzy_find<CR>', { noremap = true, silent = true })

-- Gemini.nvim
vim.keymap.set({"n", "v"}, "<leader>ga", ":GeminiCodeExplain<CR>", { noremap = true, silent = true, desc = "Gemini: Explain Code" })
vim.keymap.set({"n", "v"}, "<leader>gt", ":GeminiUnitTest<CR>", { noremap = true, silent = true, desc = "Gemini: Unit Test" })
vim.keymap.set({"n", "v"}, "<leader>gr", ":GeminiCodeReview<CR>", { noremap = true, silent = true, desc = "Gemini: Code Review" })

-- Diffview (diffs visuels Git)
vim.keymap.set("n", "<leader>gd", ":DiffviewOpen<CR>", { noremap = true, silent = true, desc = "Git Diff View" })
vim.keymap.set("n", "<leader>gD", ":DiffviewClose<CR>", { noremap = true, silent = true, desc = "Close Diff View" })
vim.keymap.set("n", "<leader>gf", ":DiffviewFileHistory %<CR>", { noremap = true, silent = true, desc = "File History" })
vim.keymap.set("n", "<leader>gF", ":DiffviewFileHistory<CR>", { noremap = true, silent = true, desc = "All Files History" })

-- Alpha
vim.keymap.set("n", "<leader>w", "<C-w>w", { noremap = true })

-- Raccourcis style macOS (Cmd+C, Cmd+V, Cmd+A)
vim.keymap.set({ "n", "v" }, "<D-c>", '"+y', { noremap = true, silent = true, desc = "Copier dans le presse-papier système" })
vim.keymap.set("n", "<D-v>", '"+p', { noremap = true, silent = true, desc = "Coller depuis le presse-papier système" })
vim.keymap.set("i", "<D-v>", '<C-r>+', { noremap = true, silent = true, desc = "Coller en mode insertion" })
vim.keymap.set("n", "<D-a>", "ggVG", { noremap = true, silent = true, desc = "Tout sélectionner" })
-- Cmd+X : Couper (comme sur macOS)
vim.keymap.set("v", "<D-x>", '"+d', { noremap = true, silent = true, desc = "Couper dans le presse-papier système" })
vim.keymap.set("n", "<D-x>", '"+dd', { noremap = true, silent = true, desc = "Couper la ligne dans le presse-papier système" })

-- Buffer management
vim.keymap.set("n", "<leader>=", ':lua require("buffer_manager.ui").toggle_quick_menu()<CR>')
vim.keymap.set("n", "<leader>q", ":bw!<CR>")

-- Terminal
vim.api.nvim_set_keymap('t', '<Esc>', [[<C-\><C-n>]], { noremap = true, silent = true })

-- Buffer navigation
vim.keymap.set("n", "<leader>s", ":bprevious<CR>", { noremap = true, silent = true, desc = "Previous Buffer" })
vim.keymap.set("n", "<leader>d", ":bnext<CR>", { noremap = true, silent = true, desc = "Next Buffer" })

-- LSP
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true, desc = "Go to Definition" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { noremap = true, silent = true, desc = "View References" })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { noremap = true, silent = true, desc = "Go to Implementation" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true, silent = true, desc = "Hover Documentation" })
vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { noremap = true, silent = true, desc = "Go to Type Definition" })
vim.keymap.set("n", "<leader>ds", vim.lsp.buf.document_symbol, { noremap = true, silent = true, desc = "View Document Symbols" })
vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, { noremap = true, silent = true, desc = "Search Workspace Symbols" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { noremap = true, silent = true, desc = "Code Action" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { noremap = true, silent = true, desc = "Rename Symbol" })
vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, { noremap = true, silent = true, desc = "Signature Help" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { noremap = true, silent = true, desc = "Previous Diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { noremap = true, silent = true, desc = "Next Diagnostic" })
vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, { noremap = true, silent = true, desc = "Diagnostic List" })
vim.keymap.set("n", "<leader>k", vim.diagnostic.open_float, { noremap = true, silent = true, desc = "Show Diagnostic Float" })

-- Dev Container
vim.keymap.set("n", "<leader>ds", ":DevcontainerSelect<CR>", { noremap = true, silent = true, desc = "Select Docker Container" })

-- Python Format
vim.keymap.set("n", "<leader>pf", ":PythonFormat<CR>", { noremap = true, silent = true, desc = "Format Python file" })


