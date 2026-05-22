return {
  {
    "mason-org/mason.nvim",
    opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        -- Ruby
        "ruby_lsp",
        "rubocop",
        -- JavaScript/TypeScript
        "ts_ls",
        "eslint",
        -- Clojure
        "clojure_lsp",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      vim.lsp.config("ruby_lsp", { capabilities = capabilities })
      vim.lsp.config("rubocop", {capabilities = capabilities })
      vim.lsp.config("ts_ls", { capabilities = capabilities })
      vim.lsp.config("eslint", {capabilities = capabilities })
    end
  }
}
