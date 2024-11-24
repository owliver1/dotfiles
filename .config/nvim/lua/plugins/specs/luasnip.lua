return {
  "L3MON4D3/LuaSnip",
  event = "InsertEnter",
  dependencies = {
    "rafamadriz/friendly-snippets", -- Predefined snippets
  },
  config = function()
    require("luasnip.loaders.from_vscode").lazy_load() -- Load VSCode-style snippets
  end,
}

