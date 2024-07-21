return {
  'nvim-tree/nvim-tree.lua',
  lazy = false,
  config = function()
    vim.cmd [[hi NvimTreeNormal guibg=NONE ctermbg=NONE]]
    require('nvim-tree').setup {
      view = {
        width = 25,
      },
      filters = {
        dotfiles = true,
      },
    }
  end,
}
