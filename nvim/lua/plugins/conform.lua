return {
  "stevearc/conform.nvim",
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>gf",
      function()
        require("conform").format({ async = true })
      end,
      desc = "Format buffer",
    }
  },
  opts = {
    formatters_by_ft = {
      javascript = { "prettier" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      ruby = { "rubocop" },
    },
  },
}
