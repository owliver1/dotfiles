return {
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",  -- Automatically update parsers
    config = function()
        require'nvim-treesitter.configs'.setup {
            -- A list of parser names, or "all" (the listed parsers MUST always be installed)
            ensure_installed = { "python", "lua", "vim", "vimdoc", "c", "markdown", "markdown_inline" },

            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },

        } 
    end,
  },
}

