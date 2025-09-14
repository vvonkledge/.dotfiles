-- fzf.lua - Blazing fast fuzzy finder
return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  cmd = 'FzfLua',
  keys = {
    -- File operations
    { '<C-p>', '<cmd>FzfLua files<cr>', desc = 'Find files' },
    { '<leader>ff', '<cmd>FzfLua files<cr>', desc = 'Find files' },
    { '<leader>fr', '<cmd>FzfLua oldfiles<cr>', desc = 'Recent files' },
    { '<leader>fb', '<cmd>FzfLua buffers<cr>', desc = 'Find buffers' },
    
    -- Search operations
    { '<leader>fg', '<cmd>FzfLua live_grep<cr>', desc = 'Live grep' },
    { '<leader>fw', '<cmd>FzfLua grep_cword<cr>', desc = 'Search word under cursor' },
    { '<leader>fW', '<cmd>FzfLua grep_cWORD<cr>', desc = 'Search WORD under cursor' },
    { '<leader>fs', '<cmd>FzfLua grep_visual<cr>', mode = 'v', desc = 'Search selection' },
    
    -- Git operations
    { '<leader>gf', '<cmd>FzfLua git_files<cr>', desc = 'Git files' },
    { '<leader>gs', '<cmd>FzfLua git_status<cr>', desc = 'Git status' },
    { '<leader>gc', '<cmd>FzfLua git_commits<cr>', desc = 'Git commits' },
    { '<leader>gb', '<cmd>FzfLua git_branches<cr>', desc = 'Git branches' },
    
    -- LSP operations
    { '<leader>lr', '<cmd>FzfLua lsp_references<cr>', desc = 'LSP references' },
    { '<leader>ld', '<cmd>FzfLua lsp_definitions<cr>', desc = 'LSP definitions' },
    { '<leader>ls', '<cmd>FzfLua lsp_document_symbols<cr>', desc = 'Document symbols' },
    { '<leader>lS', '<cmd>FzfLua lsp_workspace_symbols<cr>', desc = 'Workspace symbols' },
    { '<leader>la', '<cmd>FzfLua lsp_code_actions<cr>', desc = 'Code actions' },
    { '<leader>lD', '<cmd>FzfLua diagnostics_document<cr>', desc = 'Document diagnostics' },
    
    -- Other useful mappings
    { '<leader>fh', '<cmd>FzfLua help_tags<cr>', desc = 'Help tags' },
    { '<leader>fk', '<cmd>FzfLua keymaps<cr>', desc = 'Keymaps' },
    { '<leader>fc', '<cmd>FzfLua commands<cr>', desc = 'Commands' },
    { '<leader>fm', '<cmd>FzfLua marks<cr>', desc = 'Marks' },
    { '<leader>fj', '<cmd>FzfLua jumps<cr>', desc = 'Jumps' },
    { '<leader>f/', '<cmd>FzfLua search_history<cr>', desc = 'Search history' },
    { '<leader>f:', '<cmd>FzfLua command_history<cr>', desc = 'Command history' },
    
    -- Quick access
    { '<leader><space>', '<cmd>FzfLua resume<cr>', desc = 'Resume last search' },
  },
  config = function()
    local fzf = require('fzf-lua')
    
    fzf.setup({
      -- Use telescope profile as base with customizations
      'telescope',
      
      -- Global options
      global_resume = true,
      global_resume_query = true,
      
      -- Window options
      winopts = {
        height = 0.85,
        width = 0.80,
        row = 0.35,
        col = 0.50,
        border = 'rounded',
        preview = {
          default = 'bat',
          border = 'border',
          wrap = 'nowrap',
          hidden = 'nohidden',
          vertical = 'down:45%',
          horizontal = 'right:50%',
          layout = 'flex',
          flip_columns = 100,
          title = true,
          title_pos = 'center',
          scrollbar = 'float',
          delay = 100,
        },
      },
      
      -- Keymaps inside fzf window
      keymap = {
        builtin = {
          ['<F1>'] = 'toggle-help',
          ['<F2>'] = 'toggle-fullscreen',
          ['<F3>'] = 'toggle-preview-wrap',
          ['<F4>'] = 'toggle-preview',
          ['<F5>'] = 'toggle-preview-ccw',
          ['<F6>'] = 'toggle-preview-cw',
          ['<C-d>'] = 'preview-page-down',
          ['<C-u>'] = 'preview-page-up',
          ['<S-left>'] = 'preview-page-reset',
        },
        fzf = {
          ['ctrl-z'] = 'abort',
          ['ctrl-f'] = 'half-page-down',
          ['ctrl-b'] = 'half-page-up',
          ['ctrl-a'] = 'beginning-of-line',
          ['ctrl-e'] = 'end-of-line',
          ['alt-a'] = 'toggle-all',
          ['f3'] = 'toggle-preview-wrap',
          ['f4'] = 'toggle-preview',
          ['shift-down'] = 'preview-page-down',
          ['shift-up'] = 'preview-page-up',
        },
      },
      
      -- File and grep options
      files = {
        prompt = 'Files❯ ',
        multiprocess = true,
        git_icons = true,
        file_icons = true,
        color_icons = true,
        find_opts = [[-type f -not -path '*/\.git/*' -printf '%P\n']],
        rg_opts = "--color=never --files --hidden --follow -g '!.git'",
        fd_opts = "--color=never --type f --hidden --follow --exclude .git",
      },
      
      grep = {
        prompt = 'Rg❯ ',
        input_prompt = 'Grep For❯ ',
        multiprocess = true,
        git_icons = true,
        file_icons = true,
        color_icons = true,
        grep_opts = '--binary-files=without-match --line-number --recursive --color=auto --perl-regexp -e',
        rg_opts = '--column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e',
        rg_glob = true,
        glob_flag = '--iglob',
        glob_separator = '%s%-%-',
      },
      
      -- LSP options
      lsp = {
        prompt_postfix = '❯ ',
        cwd_only = false,
        async_or_timeout = 5000,
        file_icons = true,
        git_icons = false,
        symbols = {
          async_or_timeout = true,
          symbol_style = 1,
          symbol_hl_prefix = 'CmpItemKind',
        },
        code_actions = {
          prompt = 'Code Actions❯ ',
          async_or_timeout = 5000,
        },
      },
      
      -- Git options
      git = {
        files = {
          prompt = 'Git Files❯ ',
          cmd = 'git ls-files --exclude-standard',
          multiprocess = true,
          git_icons = true,
          file_icons = true,
          color_icons = true,
        },
        status = {
          prompt = 'Git Status❯ ',
          cmd = 'git -c color.status=false status -su',
          file_icons = true,
          git_icons = true,
          color_icons = true,
          previewer = 'git_diff',
        },
        commits = {
          prompt = 'Git Commits❯ ',
          cmd = 'git log --color --pretty=format:"%C(yellow)%h%Creset %Cgreen(%><(12)%cr%><|(12))%Creset %s %C(blue)<%an>%Creset"',
          preview = 'git show --color {1}',
          git_icons = true,
        },
        branches = {
          prompt = 'Git Branches❯ ',
          cmd = 'git branch --all --color',
          preview = 'git log --graph --pretty=oneline --abbrev-commit --color {1}',
        },
      },
      
      -- Colorscheme with better contrast for selected line
      fzf_colors = {
        ['fg'] = { 'fg', 'Normal' },
        ['bg'] = { 'bg', 'Normal' },
        ['hl'] = { 'fg', 'Comment' },
        ['fg+'] = { 'fg', 'Normal' },         -- Keep text normal color
        ['bg+'] = { 'bg', 'Visual' },         -- Use Visual selection bg for better contrast
        ['hl+'] = { 'fg', 'Conditional' },    -- Use blue for matched text on selected line
        ['info'] = { 'fg', 'PreProc' },
        ['prompt'] = { 'fg', 'Conditional' },
        ['pointer'] = { 'fg', 'Exception' },
        ['marker'] = { 'fg', 'Keyword' },
        ['spinner'] = { 'fg', 'Label' },
        ['header'] = { 'fg', 'Comment' },
      },
      
      -- Previewers
      previewers = {
        bat = {
          cmd = 'bat',
          args = '--color=always --style=numbers,changes --line-range :500',
          theme = 'GitHub',
        },
        head = {
          cmd = 'head',
          args = '-n 100',
        },
        git_diff = {
          cmd_deleted = 'git diff HEAD --color {file} | grep -E "^[-]" | sed "s/^-//g"',
          cmd_modified = 'git diff HEAD --color {file}',
          cmd_untracked = 'git diff --no-index --color /dev/null {file}',
        },
      },
    })
    
    -- Custom commands
    vim.api.nvim_create_user_command('FzfDotfiles', function()
      fzf.files({ cwd = '~/.config/nvim' })
    end, { desc = 'Search dotfiles' })
    
    vim.api.nvim_create_user_command('FzfProjects', function()
      fzf.files({ cwd = '~/projects' })
    end, { desc = 'Search projects' })
  end,
}