-- Options
local options = {
    -- line options
    number = true,
    relativenumber = true,
    numberwidth = 2,
    cursorline = true,
    scrolloff = 8,
    wrap = false,
    
    -- tabs and indentation options
    expandtab = true,
    shiftwidth = 4,
    tabstop = 4,
    smartindent = true, -- Fixed: should be a boolean

    -- search options
    ignorecase = true,
    smartcase = true,
    incsearch = true,

    -- backup and undo options
    undofile = true,

    -- mouse options
    mouse = "a",

    -- disables -- MODE --
    showmode = false,

    -- spell settings
    spell = true,
    spelllang = { "en", "pt" },
}

-- Apply the options
for key, value in pairs(options) do
    vim.opt[key] = value
end
