return {
    "goodlord/alpha-nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },

    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.startify")

        dashboard.section.header.val = {
            [[                               88                        88                    ]],
            [[                               88                        ""                    ]],
            [[                               88                                              ]],
            [[ ,adPPYba,  8b      db      d8 88            8b       d8 88 88,dPYba,,adPYba,  ]],
            [[a8"     "8a `8b    d88b    d8´ 88  88888888  `8b     d8´ 88 88P'   "88"    "8a ]],
            [[8b       d8  `8b  d8'`8b  d8´  88  88888888   `8b   d8´  88 88      88      88 ]],
            [["8a,   ,a8"   `8bd8'  `8bd8´   88              `8b d8´   88 88      88      88 ]],
            [[ `"YbbdP"´      YP      YP     88                "8"     88 88      88      88 ]], 
        }
        dashboard.section.header.align = "center"


        alpha.setup(dashboard.opts)
    end,
}
