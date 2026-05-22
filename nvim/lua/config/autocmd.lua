vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 then
      require("neo-tree.command").execute({ toggle = false })
    end
  end,
})
