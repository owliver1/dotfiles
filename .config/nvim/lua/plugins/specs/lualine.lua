return {
  "nvim-lualine/lualine.nvim",
  lazy = false, -- Always load Lualine
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- Optional for icons
  config = function()
    require("lualine").setup({
      options = {
        theme = "rose-pine", -- Match your colorscheme
        icons_enabled = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
    })
  end,
}

