return {
  "tpope/vim-fugitive",
  event = "BufReadPre",
  cmd = { "Gstatus", "Gdiffsplit", "Gblame", "Gcommit" },
}
