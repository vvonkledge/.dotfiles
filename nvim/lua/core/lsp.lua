-- Native LSP Configuration for TypeScript and Rust
-- Uses Neovim's built-in LSP client without external plugins

-- Helper function to find project root
local function find_root(markers)
  return function(fname)
    local path = fname or vim.api.nvim_buf_get_name(0)
    local root = vim.fs.root(path, markers)
    return root or vim.fn.getcwd()
  end
end

-- Helper function to find executable
local function find_cmd(cmd_names)
  for _, cmd in ipairs(cmd_names) do
    local path = vim.fn.exepath(cmd)
    if path ~= '' then
      return path
    end
  end
  -- Fallback to first option if nothing found
  return cmd_names[1]
end

-- Configure TypeScript language server
vim.lsp.config.ts_ls = {
  cmd = {find_cmd({'typescript-language-server', '/Users/vvonkledge/.volta/tools/image/node/24.8.0/bin/typescript-language-server'}), '--stdio'},
  root_dir = find_root({'package.json', 'tsconfig.json', '.git'}),
  filetypes = {'typescript', 'typescriptreact', 'javascript', 'javascriptreact'},
  single_file_support = true,
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
}

-- Configure Rust analyzer
vim.lsp.config.rust_analyzer = {
  cmd = {find_cmd({'rust-analyzer', '/Users/vvonkledge/.cargo/bin/rust-analyzer'})},
  root_dir = find_root({'Cargo.toml', 'rust-project.json', '.git'}),
  filetypes = {'rust'},
  single_file_support = true,
  settings = {
    ['rust-analyzer'] = {
      cargo = {
        allFeatures = true,
        loadOutDirsFromCheck = true,
        noDefaultFeatures = false,
      },
      checkOnSave = {
        enable = false,  -- Disable for single files without Cargo.toml
      },
      diagnostics = {
        enable = true,
        experimental = {
          enable = true,
        },
        -- Disable workspace not found warning
        warningsAsHint = {
          'unlinked-file',
        },
      },
      procMacro = {
        enable = true,
      },
      inlayHints = {
        enable = true,
        bindingModeHints = {
          enable = true,
        },
        chainingHints = {
          enable = true,
        },
        closingBraceHints = {
          enable = true,
          minLines = 25,
        },
        closureReturnTypeHints = {
          enable = 'always',
        },
        lifetimeElisionHints = {
          enable = 'always',
          useParameterNames = true,
        },
        maxLength = 25,
        parameterHints = {
          enable = true,
        },
        reborrowHints = {
          enable = 'always',
        },
        renderColons = true,
        typeHints = {
          enable = true,
          hideClosureInitialization = false,
          hideNamedConstructor = false,
        },
      },
    },
  },
}

-- Start LSP servers automatically for configured filetypes
vim.api.nvim_create_autocmd('FileType', {
  pattern = {'typescript', 'typescriptreact', 'javascript', 'javascriptreact', 'rust'},
  callback = function(args)
    local bufnr = args.buf
    local ft = vim.bo[bufnr].filetype
    local fname = vim.api.nvim_buf_get_name(bufnr)
    
    -- Determine which LSP to start based on filetype
    local server_name = nil
    local settings = nil
    
    if ft == 'rust' then
      server_name = 'rust_analyzer'
      settings = vim.deepcopy(vim.lsp.config[server_name].settings)
      
      -- Check if we're in a Cargo project
      local has_cargo = vim.fs.root(fname, {'Cargo.toml'}) ~= nil
      if has_cargo then
        -- Enable full features for Cargo projects
        settings['rust-analyzer'].checkOnSave.enable = true
        settings['rust-analyzer'].checkOnSave.command = 'clippy'
      else
        -- For single files, use minimal configuration
        settings['rust-analyzer'].checkOnSave.enable = false
        settings['rust-analyzer'].linkedProjects = {}
      end
    elseif ft == 'typescript' or ft == 'typescriptreact' or ft == 'javascript' or ft == 'javascriptreact' then
      server_name = 'ts_ls'
      settings = vim.lsp.config[server_name].settings
    end
    
    if server_name then
      vim.lsp.start({
        name = server_name,
        cmd = vim.lsp.config[server_name].cmd,
        root_dir = vim.lsp.config[server_name].root_dir(fname),
        settings = settings,
        single_file_support = true,
      }, {
        bufnr = bufnr,
      })
    end
  end,
})

-- LSP Keybindings
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local bufnr = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
    
    -- Buffer local mappings
    local opts = { buffer = bufnr, silent = true }
    
    -- Navigation
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
    
    -- Documentation
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)
    
    -- Workspace
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    
    -- Code actions
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    
    -- Formatting
    vim.keymap.set('n', '<leader>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
    
    -- Diagnostics
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)
    
    -- Enable inlay hints if supported
    if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
      vim.keymap.set('n', '<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end, opts)
    end
  end,
})

-- Diagnostic configuration
vim.diagnostic.config({
  virtual_text = {
    prefix = '●',
    source = 'if_many',
  },
  float = {
    source = 'always',
    border = 'rounded',
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- Change diagnostic symbols in the sign column (gutter)
local signs = { Error = "✘ ", Warn = "▲ ", Hint = "⚑ ", Info = "» " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Add borders to floating windows
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    border = 'rounded',
  }
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help, {
    border = 'rounded',
  }
)