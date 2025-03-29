return {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("cyberdream").setup({
            -- Options de configuration ici
            transparent = true,
            highlights = {
        LineNr = { fg = "#FFFFFF" }, -- Couleur des numéros de ligne
        NormalFloat = { bg = "NONE" }, -- Fenêtres flottantes transparentes
    },
        })
        vim.cmd("colorscheme cyberdream")
    end,
}
