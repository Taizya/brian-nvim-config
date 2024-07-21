return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    config = false,
    init = function()
      -- Disable automatic setup, we are doing it manually
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
  },
  {
    'williamboman/mason.nvim',
    lazy = false,
    config = true,
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
      },
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'saadparwaiz1/cmp_luasnip',
      'onsails/lspkind.nvim',
    },
    config = function()
      -- Here is where you configure the autocompletion settings.
      local lsp_zero = require 'lsp-zero'
      lsp_zero.extend_cmp()

      -- And you can configure cmp even more, if you want to.
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      local lspkind = require 'lspkind'

      cmp.setup {
        completion = { completeopt = 'menu,menuone,noinsert' },
        window = {
          completion = cmp.config.window.bordered {
            winhighlight = 'Normal:Normal,FloatBorder:BorderBG,CursorLine:PmenuSel,Search:None',
          },
          documentation = cmp.config.window.bordered {
            winhighlight = 'Normal:Normal,FloatBorder:BorderBG,CursorLine:PmenuSel,Search:None',
          },
        },

        mapping = cmp.mapping.preset.insert {
          ['<C-j>'] = cmp.mapping.select_next_item(),
          ['<C-k>'] = cmp.mapping.select_prev_item(),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<CR>'] = cmp.mapping.confirm { select = true },
          ['<C-Space>'] = cmp.mapping.complete {},
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),
        },
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        },
        formatting = {
          format = lspkind.cmp_format {
            mode = 'symbol_text',
            maxwidth = 50,
            ellipsis = '...',
          },
        },
      }
    end,
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'williamboman/mason-lspconfig.nvim' },
    },
    config = function()
      local lsp_zero = require 'lsp-zero'
      lsp_zero.extend_lspconfig()

      lsp_zero.set_sign_icons {
        error = '✘',
        warn = '',
        hint = '⚑',
        info = '',
      }

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('user_lsp_attach', { clear = true }),
        callback = function(event)
          local opts = { buffer = event.buf }

          vim.keymap.set('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<cr>', { desc = '' })
          vim.keymap.set('n', 'K', '<cmd>vim.lsp.buf.hover()<cr>', { desc = 'Displays hover information' })
          vim.keymap.set('n', 'gd', '<cmd>vim.lsp.buf.definition()<cr>', { desc = '' })
          vim.keymap.set('n', 'gD', '<cmd>vim.lsp.buf.declaration()<cr>', { desc = '' })
          vim.keymap.set('n', 'gi', '<cmd>vim.lsp.buf.implementation()<cr>', { desc = '' })
          vim.keymap.set('n', 'go', '<cmd>vim.lsp.buf.type.defintion()<cr>', { desc = '' })
          vim.keymap.set('n', 'gr', '<cmd>vim.lsp.buf.references()<cr>', { desc = '' })
          vim.keymap.set('n', 'gs', '<cmd>vim.lsp.buf.signature.help()<cr>', { desc = '' })
          vim.keymap.set('n', '<leader>rn', '<cmd>vim.lsp.buf.rename()<cr>', { desc = '' })
          vim.keymap.set('n', '<leader>fm', '<cmd>vim.lsp.buf.format()<cr>', { desc = '' })
          vim.keymap.set('n', '<leader>ca', '<cmd>vim.lsp.buf.code_action()<cr>', { desc = '' })
          vim.keymap.set('n', 'gl', '<cmd>vim.diagnostic.open_float()<cr>', { desc = '' })
          vim.keymap.set('n', '<leader>dn', '<cmd>vim.diagnostic.goto_next()<cr>', { desc = '' })
          vim.keymap.set('n', '<leader>dp', '<cmd>vim.diagnostic.goto_prev()<cr>', { desc = '' })
        end,
      })

      local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

      local servers = {
        pyright = {
          filetypes = { 'python' },
        },
        tsserver = {},
        html = {},
        cssls = {},
        emmet_ls = {
          filetypes = { 'html', 'css', 'javascript', 'javascript', 'typescriptreact', 'javacriptreact' },
          init_options = {
            html = {
              options = {
                ['bem.enabled'] = true,
              },
            },
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },
      }

      require('mason-lspconfig').setup {
        ensure_installed = {
          'pyright',
          'lua_ls',
          'cssls',
          'html',
          'emmet_ls',
          'tsserver',
          'jsonls',
        },
        handlers = {
          function(server_name)
            require('lspconfig').servers[server_name].setup {
              capabilities = lsp_capabilities,
            }
          end,
          lua_ls = function()
            require('lspconfig').lua_ls.setup {
              capabilities = lsp_capabilities,
              settings = {
                Lua = {
                  runtime = {
                    version = 'LuaJIT',
                  },
                  diagnostics = {
                    globals = { 'vim' },
                  },
                  workspace = {
                    library = {
                      vim.env.VIMRUNTIME,
                    },
                  },
                },
              },
            }
          end,
        },
      }
    end,
  },
}
