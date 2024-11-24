return {
  -- LSP and related utilities
  "neovim/nvim-lspconfig", -- Base LSP configuration
  dependencies = {
    "williamboman/mason.nvim", -- Install LSP servers
    "williamboman/mason-lspconfig.nvim", -- Bridge for Mason and LSPConfig
  },
  config = function()
    -- Setup Mason
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "pyright", "clangd" }, -- Add more as needed
    })

    -- Configure LSP servers
    local lspconfig = require("lspconfig")
    lspconfig.lua_ls.setup({}) -- Lua
    lspconfig.pyright.setup({}) -- Python
    lspconfig.clangd.setup({}) -- C/C++

  end,
}

