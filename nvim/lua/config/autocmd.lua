vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 then
      vim.schedule(function()
        require("neo-tree.command").execute({ action = "show", position = "left" })
      end)
    end
  end,
})
