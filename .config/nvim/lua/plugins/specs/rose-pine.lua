return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false, -- Load immediately
    priority = 1000, -- Ensure it loads first
    config = function()
      -- Set up Rose Pine configuration
      require("rose-pine").setup({
        variant = "moon", -- Options: 'main', 'moon', 'dawn'
        dark_variant = "main", -- Default dark variant
        bold_vert_split = false,
        dim_nc_background = true,
        disable_background = false,
        disable_float_background = true,
        highlight_groups = {
          CursorLine = { bg = "rose", blend = 10 },
          ColorColumn = { bg = "pine" },
        },
      })
      -- Apply the colorscheme
      vim.cmd("colorscheme rose-pine")
    end,
  },
}

