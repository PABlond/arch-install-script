return {
    "neoclide/coc.nvim",
    branch = "release",
    config = function()
        vim.g.coc_global_extensions = { "coc-prettier", "coc-tsserver", "coc-json", "coc-eslint", "coc-react-refactor", "coc-prisma" }  
    end
}
