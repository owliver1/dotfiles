-- ~/.config/nvim/lua/plugins/specs/nvim-cmp.lua
return {
  "hrsh7th/nvim-cmp",  -- Plugin spec for nvim-cmp
  dependencies = {
    "L3MON4D3/LuaSnip",            -- Snippet support
    "saadparwaiz1/cmp_luasnip",    -- LuaSnip source for nvim-cmp
    "hrsh7th/cmp-nvim-lsp",        -- LSP completion
    "hrsh7th/cmp-buffer",          -- Buffer completion
    "hrsh7th/cmp-path",            -- Path completion
  },
  config = function()
    -- Configuration directly here for nvim-cmp
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)  -- Expands snippets using LuaSnip
        end,
      },
      mapping = {
        ["<A-j>"] = cmp.mapping.select_next_item(),  -- Next item
        ["<A-k>"] = cmp.mapping.select_prev_item(),  -- Previous item
        ["<CR>"] = cmp.mapping.confirm({ select = true }),  -- Confirm selection
      },
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      }),
    })
  end,
}

