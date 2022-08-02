local treesitter = require('nvim-treesitter.configs')

treesitter.setup {
    ensure_installed = {
                        "bash",
                        "dockerfile",
                        "go",
                        "hcl",
                        "json",
                        "lua",
                        "markdown",
                        "python",
                        "rust",
                        "yaml"
                        },
    highlight = {
        enable = true
    }
}

