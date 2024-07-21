return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    local bufferline = require 'bufferline'
    bufferline.setup {
      options = {
        mode = 'buffers',
        separator_style = 'thick',
        diagnostics = 'nvim_lsp',
        indicator = {
          style = 'underline',
        },
        offsets = {
          {
            filetype = 'NvimTree',
            text = 'File Explorer',
            separator = true,
          },
        },
      },
    }
  end,
}
