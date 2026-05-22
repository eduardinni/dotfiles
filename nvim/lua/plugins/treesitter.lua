return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = function()
    require("nvim-treesitter").install()
  end,
  config = function()
    require("nvim-treesitter").setup({
      auto_install = true,
      highlight = {
        enable = true,
        disable = { "lua" },
      },
      indent = { enable = true },
    })
  end
}
