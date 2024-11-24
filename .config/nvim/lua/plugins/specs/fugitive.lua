return {
  -- Fugitive
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G" }, -- Load only when these commands are called
    keys = {
      { "<leader>gs", ":Git<CR>", desc = "Open Git status" },
    },
  },
}

